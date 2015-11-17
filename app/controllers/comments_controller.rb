class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to blog_path(@comment.blog)
  end

  private
    def comment_params
        params.require(:comment).permit(:content, :user_id, :blog_id)
    end
end
