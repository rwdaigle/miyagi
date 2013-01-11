module PageHelpers

  def articles(limit = 10)
    @articles ||= sitemap.resources.select { |r| r.path.start_with?('articles/') }.sort { |a, b| Date.parse(b.data['date']) <=> Date.parse(a.data['date'])}[0..limit]
  end
end