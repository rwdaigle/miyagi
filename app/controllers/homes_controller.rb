class HomesController < ApplicationController

  def index
    @articles = Article.published.recent.limit(10)
    # fresh_when(last_modified: @articles.maximum(:updated_at))
  end
end