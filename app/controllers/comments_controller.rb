class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.save
    #redirect_to @comment.blog
    respond_to do |format|
      format.js
    end
=begin    if @comment.save
      #如果留言通过验证.就保存.跳转到正在打开的博客页,如果不通过,就要显示出错误信息
      redirect_to @comment.blog
    else
      render @comment.blog
    end
=end
    #render plain: params.inspect
  end

  private
    def comment_params
        params.require(:comment).permit(:content, :user_id, :blog_id)
    end
end
