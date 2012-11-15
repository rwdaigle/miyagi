class ApplicationController < ActionController::Base

  protect_from_forgery
  before_filter :ensure_user

  def ensure_user
    log_in_user(User.create_anonymous_user) unless logged_in?
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= session[:user_id] ? User.where(:id => session[:user_id]).first : nil
  end

  private

  def log_in_user(user)
    session[:user_id] = user.id
  end

  def log_out_user
    reset_session
  end
end
