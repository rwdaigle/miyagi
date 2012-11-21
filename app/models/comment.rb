class Comment < ActiveRecord::Base

  attr_accessible :user_id, :body

  validates_presence_of :user_id, :body

  belongs_to :user
  before_save :generate_html

  private

  def generate_html
    self.body_html = MarkdownRenderer.to_html(body)
  end

end