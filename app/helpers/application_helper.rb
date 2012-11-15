module ApplicationHelper

  def m(content)
    @renderer ||= Redcarpet::Render::XHTML.new(:filter_html => true, :safe_links_only => true, :with_toc_data => true)
    @markdown ||= Redcarpet::Markdown.new(@renderer, :autolink => true,
      :no_intra_emphasis => true, :tables => true, :fenced_code_blocks => true, :autolink => true,
      :strikethrough => true)
    @markdown.render(content).html_safe
  end
end