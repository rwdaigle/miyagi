class MarkdownRenderer

  class << self

    def to_html(content)
      @renderer ||= PygmentizeXHTMLRenderer.new(:filter_html => true, :safe_links_only => true, :with_toc_data => true)
      @markdown ||= Redcarpet::Markdown.new(@renderer, :autolink => true,
        :no_intra_emphasis => true, :tables => true, :fenced_code_blocks => true, :autolink => true,
        :strikethrough => true)
      html = @markdown.render(content)
    end
  end
end

class PygmentizeXHTMLRenderer < Redcarpet::Render::XHTML
  def block_code(code, language)
    Pygments.highlight(code, :lexer => language)
  end
end