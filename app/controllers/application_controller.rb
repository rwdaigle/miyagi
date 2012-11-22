class ApplicationController < ActionController::Base

  protect_from_forgery
  before_filter :ensure_registered_user, :set_log_scope

  helper_method :current_user

  def logged_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= session[:user_uuid] ? User.where(:uuid => session[:user_uuid]).first : nil
  end

  private

  def ensure_registered_user
    redirect_to register_users_path(:redirect_to => request.fullpath) if !logged_in?
  end

  def set_log_scope
    Scrolls.global_context(current_user.to_log.merge(from: request.referrer)) if logged_in?
  end

  def log_in_user(user)
    session[:user_uuid] = user.uuid
  end

  def log_out_user
    reset_session
  end

  def pjax?
    !request.headers['X-PJAX'].blank?
  end
end
