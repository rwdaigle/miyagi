class HomesController < ApplicationController

  before_filter :register_homepage_viewed_event, :only => :index

  def index
    @articles = Article.published.recent.includes(:author).limit(10)
    # fresh_when(last_modified: @articles.maximum(:updated_at))
  end

  private

  def register_homepage_viewed_event
    register_event(:homepage_viewed)
  end
end