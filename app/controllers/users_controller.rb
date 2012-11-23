class UsersController < ApplicationController

  def subscribe
    current_user.subscribe!(params[:email])
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end
end