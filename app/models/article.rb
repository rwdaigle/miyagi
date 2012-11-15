class Article < Content

  validates_presence_of :summary, :body
  before_validation :populate_summary

  private

  def populate_summary
    self.summary = body[0..250] if summary.blank? && body
  end

end