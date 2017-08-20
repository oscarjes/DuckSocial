class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out(user)
    session[:user_id] = nil
  end

  def current_user
    return @current_user if @current_user

    @current_user = User.find_by(id: session[:user_id])
  end

  def require_login
    unless current_user
      flash[:error] = "You need to be logged in to access this page."
      redirect_to new_session_path
    end
  end

  def skip_if_logged_in
    if current_user
      redirect_to newsfeed_path
    end
  end
end
