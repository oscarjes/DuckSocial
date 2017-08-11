class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new user_params
    if user.save
      redirect_to root_path
    else
      redirect_to new_user_path
    end
  end

  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
  end
end