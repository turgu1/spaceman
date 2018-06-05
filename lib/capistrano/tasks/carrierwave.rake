namespace :carrierwave do

  desc 'Create symlinks to spaceman building and floor images folder'
  task :symlink do

    on roles :app do
      puts "-----> Linking data folders for carrierwave:"

      execute "ln -nfs #{shared_path}/system/data/ #{release_path}/public/data"
    end
  end

  after "deploy:finishing", "carrierwave:symlink"
end
