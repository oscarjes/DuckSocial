class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.create(comment_params)

    respond_to do |format|
      format.html {redirect_back fallback_location: newsfeed_path}
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :wall_post_id)
  end

end