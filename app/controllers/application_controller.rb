
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :set_nav_bar
  before_action :set_nav_bar

  def current_user
    @current ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    unless logged_in?
      flash[:error] = "You can't do that! Please log in."
      redirect_to root_path
    end
  end

  def access_denied
    flash[:error] = "You can't do that!"
    redirect_to root_path
  end

  def require_admin
    access_denied unless current_user && current_user.admin?
  end

  def set_nav_bar
    @categories = Category.all
  end
end
