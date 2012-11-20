class Article < ActiveRecord::Base

  attr_accessible :author_id, :title, :summary, :body, :image_url, :published_at

  validates_presence_of :summary, :body
  validates_presence_of :title
  validates_uniqueness_of :title

  belongs_to :author, :class_name => "User"
  has_many :links, :dependent => :delete_all

  scope :published, where("published_at IS NOT NULL")
  scope :recent, order("published_at DESC")
  
  before_validation :populate_summary
  before_save :render_html, :extract_links

  private

  def populate_summary
    self.summary = body[0..250] if summary.blank? && body
  end

  def render_html
    self.body_html = MarkdownRenderer.to_html(body)
  end

  def extract_links
    self.links = LinkExtractor.external(body_html).collect { |url| Link.new(url: url) }
  end

end