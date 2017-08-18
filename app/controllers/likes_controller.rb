class LikesController < ApplicationController
  def toggle
    if params[:wall_post_id]
      @item = WallPost.find params[:wall_post_id]
    elsif params[:comment_id]
      @item = Comment.find params[:comment_id]
    end
    current_user.likes_toggle!(@item)

    respond_to do |format|
      format.html {
        redirect_back fallback_location: root_path
      }

      format.js
    end
  end
end