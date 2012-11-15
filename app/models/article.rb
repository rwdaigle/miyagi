class Article < ActiveRecord::Base

  attr_accessible :author_id, :title, :summary, :body, :image_url, :published_at

  validates_presence_of :summary, :body
  validates_presence_of :title
  validates_uniqueness_of :title

  belongs_to :author, :class_name => "User"

  scope :published, where("published_at IS NOT NULL")
  scope :recent, order("published_at DESC")
  
  before_validation :populate_summary

  private

  def populate_summary
    self.summary = body[0..250] if summary.blank? && body
  end

end