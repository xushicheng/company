class Admin::SessionsController < Admin::BaseController
  skip_before_action :login_admin_user

  def new
  end

  def login_admin_session
    user = User.find_by_name(params[:name])
    if user && user.admin? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_root_path
    else
      flash.notice = "请检查用户名和密码!"
      redirect_to new_admin_session_path
    end
  end


end

