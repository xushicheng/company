class SessionsController < ApplicationController
  def create
    user = User.from_auth(env['omniauth.auth'])
    #raise env['omniauth.auth'].to_yaml
    session[:user_id] = user.id
    flash[:notice] = "用 github成功登录"
    redirect_to root_path
  end

  def new
  end
end
