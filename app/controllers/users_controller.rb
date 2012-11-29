class UsersController < ApplicationController

  def subscribe
    current_user.subscribe!(params[:email])
    Scrolls.log(measure: "miyagi.user.subscriptions", from: request.referer)
    register_event(:subscribed) # This doesn't seem to work if subscribing from the first page view (?)
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end
end