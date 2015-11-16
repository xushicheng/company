class SessionsController < ApplicationController
  def create
    user = User.from_auth(env['omniauth.auth'])
    session[:user_id] = user.id
    #raise env['omniauth.auth'].to_yaml
    #session[:user_id] = user.id
    flash[:notice] = "外站成功登录"
    redirect_to root_path
  end

  def new
  end
end
