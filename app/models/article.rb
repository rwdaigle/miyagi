class Article < ActiveRecord::Base

  attr_accessible :author, :title, :summary, :body, :image_url, :published_at

  validates_presence_of :summary, :body
  validates_presence_of :title
  validates_uniqueness_of :title

  belongs_to :author, :class_name => "User"
  has_many :links, :dependent => :delete_all

  scope :published, where("published_at IS NOT NULL")
  scope :recent, order("published_at DESC")
  
  before_validation :populate_summary
  before_create :generate_slug
  before_save :generate_body_html, :extract_links

  def to_param
    "#{id}-#{slug}"
  end

  def to_log
    { article_id: id, article_title: title }
  end
  
  private

  def populate_summary
    self.summary = body[0..250] if summary.blank? && body
  end

  def generate_slug
    self.slug = title.to_url if slug.blank?
  end

  def generate_body_html
    self.body_html = MarkdownRenderer.to_html(body)
  end

  def extract_links
    self.links = LinkExtractor.external(body_html)
  end

end