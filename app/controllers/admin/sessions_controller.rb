class Admin::SessionsController < Admin::BaseController
  skip_before_action :login_admin_user

  def new
  end

  def login_admin_session
    user = User.find_by_name(params[:name])
    unless user && user.admin? && user.authenticate(params[:password])
      flash[:danger] = "请检查用户名和密码!"
      redirect_to new_admin_session_path
    else
      session[:user_id] = user.id
      flash[:success] = "成功登录管理员账户"
      redirect_to admin_root_path
    end
  end


end

