class HomeController < ApplicationController

  skip_authorization_check only: [:index, :back]

  def index
    session[:current_org]      = nil
    session[:current_building] = nil
    session[:current_floor]    = nil
    session[:sidebar]          = ''
  end

  def back
    if session[:back_url]
      redirect_to session[:back_url]
    else
      render action: :index
    end
  end

  def counter_cache_reset
    authorize! :read, User
    SpaceType.all.each do |st|
      SpaceType.reset_counters(st.id, :spaces)
    end
    Wing.all.each do |w|
      Wing.reset_counters(w.id, :floors)
    end
  end

  def import_data
    @import = Import.new
    authorize! :import, :database
  end

  def do_import_data
    @import = Import.new(import_params)
    authorize! :import, :database

    respond_to do |format|
      if @import.valid?
        format.html {
          @import.do_import
        }
      else
        format.html { render action: 'import_data' }
      end
    end
  end

  def backup
    authorize! :backup, :database

    data_dir = Rails.env.production? ? 'public/data' : "public/data_#{Rails.env}"
    backup_name = "tmp/spaceman_backup_#{Rails.env} #{DateTime.now.to_s.gsub(':', '.')}.zip"
    unless system "bundle", "exec", "rake", "db:dump"
      puts "!!!! Unable to run 'bundle exec rake db:dump': #{$?}"
    end
    unless system "zip", "-r", backup_name, data_dir, "db/data.yml" 
      puts "!!!! Unable to run 'zip -r #{backup_name} #{data_dir}': #{$?}"
    end
    send_file backup_name, disposition: :attachment
  end

  private
    def import_params
      params.require(:import).permit(:import_file)
    end
end