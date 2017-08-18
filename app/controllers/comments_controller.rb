class CommentsController < ApplicationController
  def create
    comment = current_user.comments.create(comment_params)
    if comment.save
      flash[:success] = "Comment added."
      redirect_back fallback_location: newsfeed_path
    else
      flash[:error] = "Something went wrong. Please try again."
      redirect_back fallback_location: newsfeed_path
    end
  end

  def comment_params
    params.require(:comment).permit(:body, :wall_post_id)
  end

end