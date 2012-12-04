class MarkdownRenderer

  class << self

    def to_html(content, options={})
      @renderer ||= PygmentizeXHTMLRenderer.new(:filter_html => true, :safe_links_only => true, :with_toc_data => true)
      @markdown ||= Redcarpet::Markdown.new(@renderer, :autolink => true,
        :no_intra_emphasis => true, :tables => true, :fenced_code_blocks => true, :autolink => true,
        :strikethrough => true)
      
      # Accept an en.yml identifier
      if options[:localize]
        @markdown.render I18n.t(content)
      else
        @markdown.render(content)
      end
    end
  end
end

class PygmentizeXHTMLRenderer < Redcarpet::Render::XHTML
  def block_code(code, language)
    Pygments.highlight(code, :lexer => language)
  end
end