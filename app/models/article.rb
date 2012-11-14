class Article < Content

  validates_presence_of :title, :summary, :body

  before_validation :populate_summary

  belongs_to :author, :class_name => "User"

  scope :recent, order("published_at DESC")

  private

  def populate_summary
    self.summary = body[0..250] if summary.blank? && body
  end

end