class Content < ActiveRecord::Base

  self.table_name = "content"

  attr_accessible :author_id, :title, :summary, :body, :published_at, :contributor_id, :target_url, :image_url, :details
  validates_presence_of :title
  validates_uniqueness_of :title, :scope => "type"

  belongs_to :author, :class_name => "User"

  scope :published, where("published_at IS NOT NULL")
  scope :recent, order("published_at DESC")
  scope :articles, where(:type => "Article")
  scope :linked, where(["type != ?", "Article"])
end