class Admin::SessionsController < Admin::BaseController
  skip_before_action :login_admin_user

  def new
  end

  def create
    user = User.find_by_name(params[:name])
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      redirect_to member_path
    else
      render plain: params.inspect
    end
  end


end

