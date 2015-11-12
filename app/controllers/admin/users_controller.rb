class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = '删除用户成功'
      redirect_to admin_users_path
    else
      flash[:error] = '删除用户失败'
      redirect_to admin_users_path
    end
  end
end
