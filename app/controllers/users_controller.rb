class UsersController < ApplicationController
  before_action :require_login, only: [:index, :find, :edit, :show] 
  before_action :skip_if_logged_in, only: [:new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to newsfeed_path
    else
      flash[:error] = "Something went wrong: #{@user.errors.full_messages.to_sentence}."
      render "new"
    end
  end

  def index
    @users = User.where.not(id: current_user.id)
    
    if params[:q]
      @users = @users.select{|s| s.fullname.include?(params["q"])}
    end
  end

  def find
    @users = User.where.not(id: current_user.id)

    if params[:q]
      @users = @users.select{|s| s.fullname.include?(params["q"])}
    end
  end

  def edit
    @user = current_user
  end

  def show
    @user = current_user
    #wallposts_combo = current_user.wall_posts.all + current_user.wall_mentions.all
    @wallposts = @user.posts_on_wall(@user).order("updated_at DESC").page(1).per(5)
    @wallpost = WallPost.new
  end

  def update
    @user = current_user
    if params[:user][:image_url]
      if @user.update(image_url: params[:user][:image_url])
      flash[:success] = "Profile picture changed successfully"
      redirect_to settings_path
      else
        flash[:error] = "Something went wrong: #{@user.errors.full_messages.to_sentence}."
        redirect_to settings_path
      end
    elsif params[:user][:old_password]
      if @user.authenticate(params[:user][:old_password])
        @user.update(password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
        flash[:success] = "Password changed successfully"
        redirect_to settings_path
      else
        flash[:error] = "Incorrect password."
        redirect_to settings_path
      end
    elsif @user.update user_params
      flash[:success] = "Profile updated successfully."
      redirect_to settings_path
    else
      flash[:error] = "Something went wrong: #{@user.errors.full_messages.to_sentence}"
      redirect_to settings_path
    end
  end

  def search
    search = params[:q] || nil
    users = User.autocomplete_by_name(search)
    render json: users
  end

  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :image_url, :avatar)
  end

end