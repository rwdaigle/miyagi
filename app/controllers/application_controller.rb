class ApplicationController < ActionController::Base

  protect_from_forgery
  before_filter :ensure_registered_user, :set_log_scope

  helper_method :current_user, :first_visit?, :event?

  def logged_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= session[:user_uuid] ? User.where(:uuid => session[:user_uuid]).first : nil
  end

  def event?(event)
    flash[:events] ? flash[:events].delete(event) : false
  end

  private

  def ensure_registered_user
    if(!logged_in?)
      log_in_user(User.create_anonymous_user)
      register_event(:first_visit)
    end
  end

  # Use the flash as a cheap transport mechanism for cross-request event tracking
  def register_event(event)
    flash[:events] ||= []
    flash[:events] << event
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
