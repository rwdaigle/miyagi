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
      xml.link "rel" => "alternate", "href" => "http://miyagijournal.com/#{article.path}"
      xml.id "http://miyagijournal.com#{article.path}"
      xml.published "#{Date.parse(article.data['date']).iso8601}T00:00:00-08:00"
      xml.updated "#{Date.parse(article.data['date']).iso8601}T00:00:00-08:00"
      xml.author { xml.name article.data['author']['name'] }
      xml.summary article.data['summary'], "type" => "html"
      xml.content article.render(:layout => false), "type" => "html"
    end
  end
end

# <?xml version="1.0" encoding="UTF-8"?>
# <feed xml:lang="en-US" xmlns="http://www.w3.org/2005/Atom">
#   <id>tag:www.miyagijournal.com,2012:/articles</id>
#   <link rel="alternate" type="text/html" href="http://www.miyagijournal.com"/>
#   <link rel="self" type="application/atom+xml" href="http://www.miyagijournal.com/articles.atom"/>
#   <title>Miyagi - An open journal on the technique of modern application development.</title>
#   <updated>2012-12-11T18:09:11Z</updated>
#   <entry>
#     <id>tag:www.miyagijournal.com,2012:Article/9</id>
#     <published>2012-12-11T18:08:32Z</published>
#     <updated>2012-12-11T18:08:32Z</updated>
#     <link rel="alternate" type="text/html" href="http://www.miyagijournal.com/articles/9-the-tortoise-and-the-octocat"/>
#     <title>The Tortoise and The Octocat</title>
#     <content type="html">