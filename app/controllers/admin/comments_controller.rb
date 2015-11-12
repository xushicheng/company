class Admin::CommentsController < Admin::BaseController
  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end
end
