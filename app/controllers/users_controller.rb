class UsersController < ApplicationController

  skip_before_filter :ensure_registered_user, :only => :register

  def register
    log_in_user(User.create_anonymous_user) unless logged_in?
    render layout: 'bare'
  end

  def subscribe
    current_user.subscribe!(params[:email])
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end
end