class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :format_time, :format_date
  helper_method :current_user
  helper_method :login_admin_user

  def format_time(time)
    time.strftime("%Y-%m-%d %H:%M")
  end

  def format_date(time)
    time.strftime("%Y.%m.%d")
  end

  private
    def current_user
      @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
    end

    def login_admin_user
      if current_user
        if current_user.admin?
          redirect_to admin_root_path
        else
          flash.notice = "普通用户无权访问后台"
          redirect_to member_path
        end
      else
        flash.notice = "请先登录管理员账户"
        redirect_to new_admin_session_path
      end
    end

end
