class Comment < ActiveRecord::Base

  attr_accessible :user_id, :body

  validates_presence_of :user_id, :body

  belongs_to :user, :touch => true
  belongs_to :article, :touch => true
  before_save :generate_body_html

  def to_log
    { comment_id: id, comment_body: body[0..100] }
  end

  private

  def generate_body_html
    self.body_html = MarkdownRenderer.to_html(body)
  end

end