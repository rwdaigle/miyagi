class LinkExtractor

  class << self

    def external(html)
      doc = Nokogiri::HTML.parse(html)
      doc.css('a').map { |link| link['href'] }.uniq
    end
  end
end