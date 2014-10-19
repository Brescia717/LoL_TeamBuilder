class ApplicationController < ActionController::Base
  after_filter :store_location

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return unless request.get?
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/users/sign_out" &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # devise_parameter_sanitizer.for(:sign_up) << [:username, :admin] ## can add :profile_photo here
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :summoner_name,
                                                            :primary_role, :secondary_role,
                                                            :lolking_profile_link,
                                                            :password, :password_confirmation,
                                                            :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :summoner_name,
                                                            :primary_role, :secondary_role,
                                                            :lolking_profile_link,
                                                            :password, :password_confirmation,
                                                            :current_password, :remember_me) }
  end

  def authorize!
    if current_user.nil? || !current_user.admin?
      flash[:warning] = "Invalid request"
      redirect_to root_path
    end
  end

  def admin_authorize!
    if !current_user.admin?
      flash[:warning] = "Invalid request"
      redirect_to root_path
    end
  end
end
