class UsersController < ApplicationController

  load_and_authorize_resource except: [
    :change_password, :do_change_password,
    :change_password_for, :do_change_password_for,
    :do_change_language
  ]

  def change_password
    @user = User.find(current_user.id)
    authorize! :update_password, @user

    respond_to do |format|
      format.js
    end
  end

  def do_change_password
    pars = change_password_params
    @user = User.find(current_user.id)
    authorize! :update_password, @user

    respond_to do |format|
      if @user.update_with_password(change_password_params)
        bypass_sign_in(@user)
        flash.now[:notice] = t('.password_update_ok', item: @user.username)
        format.js { render 'password_changed_ok' }
      else
        flash.now[:error] = t('.unable_to_change_password', item: @user.username)
        format.js  { render action: "change_password" }
      end
    end
    # respond_to do |format|
    #   if pars[:password] == pars[:password_confirmation]
    #     if @user.update_with_password(password: pars[:password], password_confirmation: pars[:password_confirmation], current_password: pars[:current_password])
    #       bypass_sign_in(@user)
    #       flash.now[:notice] = t('.password_update_ok', item: @user.username)
    #       format.js { render 'password_changed_ok' }
    #     else
    #       flash.now[:error] = t('.unable_to_change_password', item: @user.username)
    #       format.js  { render action: "change_password" }
    #     end
    #   else
    #     flash.now[:error] = t('.passwords_differ')
    #     format.js  { render action: "change_password"  }
    #   end
    # end
  end

  def change_password_for
    @user = User.find(params[:id])
    authorize! :update, @user

    respond_to do |format|
      format.js { render action: "change_password_for" }
    end
  end

  def do_change_password_for
    pars = change_password_for_params
    @user = User.find(params[:id])
    authorize! :update, @user

    respond_to do |format|
      if pars[:password] == pars[:password_confirmation]
        if @user.update!(password: pars[:password], password_confirmation: pars[:password_confirmation])
          format.js { redirect_to users_path, notice: t('.password_update_ok', item: @user.username) }
        else
          flash.now[:error] = t('.unable_to_change_password', item: @user.username)
          format.js  { render action: "change_password_for" }
        end
      else
        flash.now[:error] = t('.passwords_differ')
        format.js  { render action: "change_password_for"  }
      end
    end
  end

  def do_change_language
    pars = change_language_params
    @user = User.find(current_user.id)
    authorize! :update_language, @user

    respond_to do |format|
      if @user.update!(language: pars[:language])
        I18n.locale = @user.language
        flash.now[:notice] = t('.language_ok')
      else
        flash.now[:error] = t('.language_error')
      end
      format.js
    end
  end

  # GET /users
  # GET /users.json
  def index
    @users = @users.order(:username)

    respond_to do |format|
      format.html
      format.js   # _index.js.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js # edit.js.erb
    end
  end


  # PUT /users/1
  # PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(filter_params(user_params))
        format.html { redirect_to users_path, notice: t('.update_ok', item: @user.username) }
        format.json { head :no_content }
      else
        format.html  { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    the_name = @user.username
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_path, status: 303, notice: t('.delete_ok', item: the_name) }
      format.js { redirect_to users_path, status: 303, notice: t('.delete_ok', item: the_name) }
      format.json { head :no_content }
    end
  end

  private

    def user_params
      params.require(:user).permit(
          :username, :email, :password, :remember_me, {buildings_to_man: []}, {orgs_to_man: []},
          {roles: []}, :man_all_building, :man_all_org)
    end

    def change_password_params
      params.require(:user).permit(
        :password, :password_confirmation, :reset_password_token, :current_password)
    end

    def change_password_for_params
      params.require(:user).permit(
        :password, :password_confirmation, :reset_password_token)
    end

    def change_language_params
      params.permit(:language)
    end

    def filter_params(pars)
      pars[:roles] = pars[:roles].select { |i| !i.blank? } if pars[:roles]
      pars[:buildings_to_man] = pars[:buildings_to_man].select { |i| !i.blank? }.map { |i| i.to_i }  if pars[:buildings_to_man]
      pars[:orgs_to_man] = pars[:orgs_to_man].select { |i| !i.blank? }.map { |i| i.to_i }  if pars[:orgs_to_man]
      pars
    end
end
