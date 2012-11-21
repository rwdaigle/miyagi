class ApplicationController < ActionController::Base

  protect_from_forgery
  before_filter :ensure_user, :set_log_scope

  helper_method :current_user

  def logged_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= session[:user_id] ? User.where(:id => session[:user_id]).first : nil
  end

  private

  def ensure_user
    log_in_user(User.create_anonymous_user) unless logged_in?
  end

  def set_log_scope
    Scrolls.global_context(current_user.to_log.merge(from: request.referer)) if logged_in?
  end

  def log_in_user(user)
    session[:user_id] = user.id
  end

  def log_out_user
    reset_session
  end

  def pjax?
    !request.headers['X-PJAX'].blank?
  end
end
