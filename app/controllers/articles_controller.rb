class ArticlesController < ApplicationController

  before_filter :register_content_viewed_event, :only => :show

  def show
    @article = Article.published.find(params[:id])
    # fresh_when(@article)
  end

  private

  def register_content_viewed_event
    register_event(:content_viewed)
  end
end