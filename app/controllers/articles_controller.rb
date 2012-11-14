class ArticlesController < ApplicationController

  def show
    @article = Article.published.find(params[:id])
  end
end