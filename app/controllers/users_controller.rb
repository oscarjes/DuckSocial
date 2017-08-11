class UsersController < ApplicationController
  before_action :require_login, only: [:index] 
  before_action :skip_if_logged_in, only: [:new]

  def new
    @user = User.new
  end

  def create
    user = User.new user_params
    if user.save
      log_in(user)
      redirect_to root_path
    else
      flash[:error] = "There was an error. Please try again."
      render "new"
    end
  end

  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :image_url)
  end

  def index
    @users = User.where.not(id: current_user.id)
  end

  def edit
    @user = current_user
  end

  def show
  end

  def update
    @user = current_user
    if params[:user][:image_url]
      if @user.update(image_url: params[:user][:image_url])
      flash[:success] = "Profile picture changed successfully"
      redirect_to profile_path
      else
        flash[:error] = "Something went wrong: #{@user.errors.full_messages.to_sentence}."
        redirect_to profile_path
      end
    elsif params[:user][:old_password]
      if @user.authenticate(params[:user][:old_password])
        @user.update(password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
        flash[:success] = "Password changed successfully"
        redirect_to profile_path
      else
        flash[:error] = "Incorrect password."
        redirect_to profile_path
      end
    elsif @user.update user_params
      flash[:success] = "Profile updated successfully."
      redirect_to profile_path
    else
      flash[:error] = "Something went wrong: #{@user.errors.full_messages.to_sentence}"
      redirect_to profile_path
    end
  end
end