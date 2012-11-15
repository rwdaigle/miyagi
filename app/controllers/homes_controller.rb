class HomesController < ApplicationController

  def index
    @articles = Content.articles.published.recent.limit(3)
    @linked_content = Content.linked.published.recent.limit(10)
  end
end