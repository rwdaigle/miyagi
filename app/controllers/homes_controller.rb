class HomesController < ApplicationController

  def index
    @articles = Article.published.recent.limit(10)
  end
end