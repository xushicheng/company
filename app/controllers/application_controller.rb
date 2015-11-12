class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
#  helper_method :login_admin


  private
    def current_user
      @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
    end

=begin    def login_admin
      if current_user && current_user.admin?
          redirect_to admin_root_path
      else
        redirect_to new_admin_session_path
      end
    end
=end
end
