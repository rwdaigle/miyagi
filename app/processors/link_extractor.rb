require 'uri'

class LinkExtractor

  class << self

    def external(html)
      doc = Nokogiri::HTML.parse(html)
      links = doc.css('a').map { |link| link['href'] }.uniq
      links.reject { |url|
        host = URI(url).host
        host.nil? || host == ENV['HOST']
      }
    end
  end
end