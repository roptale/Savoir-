class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Comment successfully added!"
      redirect_to post_path(@post)
    else
      flash[:alert] = "Failed to save comment. Please try again."
      render "posts/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
