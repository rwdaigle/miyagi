module ApplicationHelper

  def m(content)
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true,
      :no_intra_emphasis => true, :tables => true, :fenced_code_blocks => true, :autolink => true,
      :strikethrough => true)
    @markdown.render(content).html_safe
  end
end