require "lib/helpers"
require "lib/pygments_renderer"

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

set :markdown_engine, :redcarpet
set :markdown, :renderer => PygmentsRenderer, :tables => true, :autolink => true, :gh_blockcode => true, :fenced_code_blocks => true,
  :no_intra_emphasis => true, :strikethrough => true, :with_toc_data => true

Time.zone = "Eastern Time (US & Canada)"

page "/", :layout => "application"
page "articles.atom", :layout => nil
page "articles/*", :layout => "article"

helpers ApplicationHelpers

activate :i18n
activate :directory_indexes
activate :livereload

configure :build do
  activate :asset_hash, :exts => ['.js', '.css', '.png', '.gif', '.jpg', '.woff']
  activate :minify_css
  activate :minify_javascript
  activate :gzip
end