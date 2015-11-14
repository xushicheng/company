class UsersController < ApplicationController
  def signup
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      cookies[:auth_token] = @user.auth_token
      redirect_to member_path
    else
      render :signup
    end
  end

  def create_login_session
    user = User.find_by_name(params[:name])
    if user.nil?
      flash[:danger] = "用户不存在!"
      redirect_to member_path
    elsif user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      redirect_to member_path
    else
      flash[:danger] = "密码输入错误!"
      redirect_to member_path
    end
  end

  def logout
    cookies.delete(:auth_token)
    redirect_to member_path
  end


  private
    def user_params
      params.require(:user).permit(:name, :email, :zone, :password, :password_confirmation)
    end
end
