class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :init_center_index
 
  # For debugging purpose only. Not to be used in production.
  # 
  # before_action :set_user

  check_authorization unless: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    redirect_to :root, alert: exception.message
  end

  private

    # For debugging purpose only. Not to be used in production.
    # 
    #def set_user
    #  @current_user = User.where(:username => 'the_username').take
    #end

    # An easy way to have Devise accept :email as an attribute for a user sign_up process
    # A before_action is required to fire this method when a devise_controller is instanciated
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    end

    def set_back_url
      session[:back_url] = request.fullpath.gsub('.js', '')
    end

    def init_center_index
      @center_index = 1
    end

    def set_locale
      if current_user.nil?
        I18n.locale = I18n.default_locale
      else
        I18n.locale = current_user.language.blank? ? I18n.default_locale : current_user.language
      end
    end

end
