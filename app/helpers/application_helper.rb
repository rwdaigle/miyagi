module ApplicationHelper

  class PygmentizeHTML < Redcarpet::Render::HTML
    def block_code(code, language)
      require 'pygmentize'
      Pygmentize.process(code, language)
    end
  end

  # TODO: Move to after_update hook on model
  def m(content)
    
    # Markdown
    @renderer ||= PygmentizeHTML.new(:filter_html => true, :safe_links_only => true, :with_toc_data => true)
    @markdown ||= Redcarpet::Markdown.new(@renderer, :autolink => true,
      :no_intra_emphasis => true, :tables => true, :fenced_code_blocks => true, :autolink => true,
      :strikethrough => true)
    html = @markdown.render(content)
    html.html_safe
  end
end