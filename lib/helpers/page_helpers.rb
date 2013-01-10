module PageHelpers

  def articles
    sitemap.resources.select { |r| r.path.start_with?('/articles') }
  end
end