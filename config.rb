set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

set :markdown, :tables => true, :autolink => true, :gh_blockcode => true, :fenced_code_blocks => true
set :markdown_engine, :redcarpet

Time.zone = "Eastern Time (US & Canada)"

configure :build do
  activate :minify_css
  activate :minify_javascript
end

activate :blog do |blog|
  blog.paginate = true
  blog.page_link = "page-:num"
  blog.per_page = 20
  blog.sources = "source/articles/"
end