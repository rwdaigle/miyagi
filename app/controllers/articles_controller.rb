class ArticlesController < ApplicationController

  before_filter :register_content_viewed_event, :only => :show

  def index
    @articles = Article.published.recent.includes(:author).limit(10)
    fresh_when(:last_modified => @articles.maximum(:updated_at))
  end

  def show
    @article = Article.published.includes(:author).find(params[:id])
    # fresh_when(@article)
  end

  private

  def register_content_viewed_event
    register_event(:content_viewed)
  end
end