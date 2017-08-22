class WallsController < ApplicationController
  before_action :require_login
  
  def show
    @user = User.find(params[:id])
    #wallposts_combo = @user.wall_posts.all + @user.wall_mentions.all
    #@wallposts = wallposts_combo.sort_by(&:created_at).reverse
    @wallposts = @user.posts_on_wall(@user).order("updated_at DESC").page(1).per(5)
    @wallpost = WallPost.new
  end

end