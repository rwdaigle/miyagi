class LinksController < ApplicationController

  def follow
    Scrolls.log(measure: "adj.link.clicks", from: request.referer, to: params[:url], context: params[:context])
    redirect_to params[:url]
  end
end