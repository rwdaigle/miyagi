class MonitorsController < ApplicationController
  
  def heartbeat
    respond_to do |format|
      format.json do
        render :json => {
          'all' => true
        }
      end
      format.html { render :ok }
    end
  end
end