class SessionsController < ApplicationController
  before_action :skip_if_logged_in, only: [:new]

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user
      if user.authenticate(params[:password])
        log_in(user)
        flash[:success] = "Successfully logged in. Welcome!"
        redirect_to profile_path
      else
        flash[:error] = "Wrong password."
        redirect_to new_session_path
      end
    else
      flash[:error] = "Wrong email address."
      redirect_to new_session_path
    end
  end

  def destroy
    log_out(current_user)
    flash[:success] = "Successfully logged out. Goodbye!"
    redirect_to root_path
  end
end