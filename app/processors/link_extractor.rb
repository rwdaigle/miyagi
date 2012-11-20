require 'uri'

class LinkExtractor

  class << self

    def external(html)
      doc = Nokogiri::HTML.parse(html)
      urls = doc.css('a').map { |link| link['href'] }.uniq
      urls.collect { |url|
        host = URI(url).host
        (host.nil? || host == ENV['HOST']) ? nil : Link.new(url: url, host: host)
      }.compact
    end
  end
end