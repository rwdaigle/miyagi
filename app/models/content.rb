class Content < ActiveRecord::Base

  self.table_name = "content"

  attr_accessible :author_id, :title, :summary, :body, :published_at, :contributor_id, :target_url, :details
  validates_uniqueness_of :title, :scope => "type"

  scope :published, where("published_at IS NOT NULL")
end