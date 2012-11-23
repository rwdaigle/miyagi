class ArticlesController < ApplicationController

  def show
    @article = Article.published.find(params[:id])
    # fresh_when(@article)
  end
end