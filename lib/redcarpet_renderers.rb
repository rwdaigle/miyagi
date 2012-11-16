require 'pygmentize'

class PygmentizeXHTMLRenderer < Redcarpet::Render::XHTML
  def block_code(code, language)
    Pygmentize.process(code, language)
  end
end