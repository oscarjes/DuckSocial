class HomeController < ApplicationController
  before_action :skip_if_logged_in, only: [:index]

  def index
  end

  def searchu
    @users = User.where.not(id: current_user.id)
    
    if params[:q]
      search = params[:q]
      search = search.downcase
      @users = @users.select{|s| s.fullname.downcase.include?(params[:q])}
    end
  end

  def searchp
    @wall_posts = WallPost.all
    
    if params[:q]
      search = params[:q]
      search = search.downcase
      @wall_posts = @wall_posts.select{|s| s.body.downcase.include?(search)}
    end
  end
end