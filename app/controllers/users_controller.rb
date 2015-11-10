class UsersController < ApplicationController
  before_action :admin_user, only: :admin

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
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      redirect_to member_path
    else
      redirect_to login_path
    end
  end

  def logout
    cookies.delete(:auth_token)
    redirect_to root_path
  end

  def admin
    @blogs = Blog.all
  end


  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end
end
