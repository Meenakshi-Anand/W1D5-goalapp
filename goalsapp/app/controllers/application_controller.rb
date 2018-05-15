class ApplicationController < ActionController::Base
protect_from_forgery with: :exception
helper_method :current_user, :logged_in?

def current_user
  @current_user ||= User.find_by(session_token: session[:session_token])
end

def logged_in?
  !!current_user
end

def login_user(user)
  @current_user = user
  session[:session_token] = user.reset_session_token!
end

def logout_user
  current_user.reset_session_token!
  @current_user = nil
  session[:session_token] = nil
end

private

def require_current_user!
  redirect_to new_user_url unless current_user
end

def require_no_current_user!
  redirect_to root_url if current_user
end
end
