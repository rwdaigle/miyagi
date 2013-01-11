xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do
  xml.title I18n.t('app.name')
  xml.subtitle I18n.t('app.tagline')
  xml.id "http://miyagijournal.com/"
  xml.link "href" => "http://miyagijournal.com/"
  xml.link "href" => "http://miyagijournal.com/articles.atom", "rel" => "self"
  xml.updated "#{Date.parse(articles.first.data['date']).iso8601}T00:00:00-08:00"

  articles.each do |article|
    xml.entry do
      xml.title article.data['title']
      xml.link "rel" => "alternate", "href" => "http://miyagijournal.com/#{article.destination_path}"
      xml.id "http://miyagijournal.com/#{article.destination_path}"
      xml.published "#{Date.parse(article.data['date']).iso8601}T00:00:00-08:00"
      xml.updated "#{Date.parse(article.data['date']).iso8601}T00:00:00-08:00"
      xml.author { xml.name article.data['author']['name'] }
      xml.summary article.data['summary'], "type" => "html"
      xml.content article.render(:layout => false), "type" => "html"
    end
  end
end