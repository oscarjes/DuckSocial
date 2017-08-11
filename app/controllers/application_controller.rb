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
end
