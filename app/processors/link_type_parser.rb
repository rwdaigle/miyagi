class LinkTypeParser

  TYPE_GITHUB = "GITHUB"
  TYPE_SPEAKERDECK = "SPEAKERDECK"
  TYPE_SLIDESHARE = "SLIDESHARE"
  TYPE_IMAGE = "IMAGE"
  TYPE_FILE = "FILE"
  TYPE_PAGE = "PAGE"

  TYPE_MATCHES = {
    %r{github.com\/\w+\/\w+} => TYPE_GITHUB,
    %r{speakerdeck.com\/\w+\/\w+} => TYPE_SPEAKERDECK,
    %r{slideshare.net\/\w+\/\w+} => TYPE_SLIDESHARE,
    %r{\.([png|gif|jpg|jpeg]+)$} => TYPE_IMAGE,
    %r{\.([pdf|zip|tar|gz]+)$} => TYPE_FILE
  }

  class << self

    def type_of(url)
      matched_type = nil
      TYPE_MATCHES.each do |regex, type|
        if(regex =~ url)
          matched_type = type
          break
        end #ugh
      end
      matched_type ? matched_type : TYPE_PAGE
    end
  end

end