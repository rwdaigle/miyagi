class CommentsController < ApplicationController

  def create
    @article = Article.published.find(params[:article_id])
    if(@article)
      @comment = @article.comments.create({ :user_id => current_user.id }.merge(params[:comment]))
    end
    redirect_to "#{request.env["HTTP_REFERER"]}#comment-#{@comment.id}"
  end
end