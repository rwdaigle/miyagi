module PageHelpers

  def articles(limit = 10)
    sitemap.resources.select { |r| r.path.start_with?('articles/') }.sort { |a, b| Date.parse(a.data['date']) <=> Date.parse(b.data['date'])}[0..limit]
  end
end