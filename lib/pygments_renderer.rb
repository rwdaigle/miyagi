class PygmentsRenderer < Redcarpet::Render::XHTML
  def block_code(code, language)
    Pygments.highlight(code, :lexer => language)
  end
end