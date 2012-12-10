atom_feed(schema_date: 2012) do |feed|
  feed.title("#{t('app.name')} - #{t('app.tagline')}")
  feed.updated(@articles[0].published_at) if @articles.length > 0

  @articles.each do |article|
    feed.entry(article) do |entry|
      entry.title(article.title)
      entry.content(article.body_html, :type => 'html')

      entry.author do |author|
        author.name(article.author.name)
        author.uri(article.author.site_url)
      end
    end
  end
end