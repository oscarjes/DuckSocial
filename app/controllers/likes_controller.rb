class LikesController < ApplicationController
  def toggle
    if params[:wallpost_id]
      item = WallPost.find params[:wallpost_id]
    end
    current_user.likes_toggle!(item)
    redirect_back fallback_location: root_path
  end
end
