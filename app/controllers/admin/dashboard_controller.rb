class Admin::DashboardController < Admin::BaseController
  def index
    @users_count = User.all.size
    @blogs_count = Blog.all.size
    @comments_count = Comment.all.size
  end
end
