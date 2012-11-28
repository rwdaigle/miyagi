class CommentsController < ApplicationController

  before_filter :set_article, :only => [:create]
  around_filter :set_article_log_scope
  before_filter :store_user_identity

  def create
    @comment = @article.comments.create({ :user_id => current_user.id }.merge(params[:comment]))
    Scrolls.context(@comment.to_log) { Scrolls.log(measure: "adj.comments.created") }
    register_event(:commented)
    redirect_to "#{request.env["HTTP_REFERER"]}#comment-#{@comment.id}"
  end

  private

  def set_article
    @article = Article.published.find(params[:article_id])
  end

  def store_user_identity
    current_user.identify!(params[:user_label], params[:user_email])
  end

  def set_article_log_scope
    Scrolls.context(@article.to_log) do
      yield      
    end
  end
end