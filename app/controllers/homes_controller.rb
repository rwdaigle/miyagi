class HomesController < ApplicationController

  def index
    @articles = Article.published.recent.limit(3)
  end
end