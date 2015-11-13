class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.save
    respond_to do |format|
      format.js
    end
  end

  private
    def comment_params
        params.require(:comment).permit(:content, :user_id, :blog_id)
    end
end
