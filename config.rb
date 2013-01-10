set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

set :markdown, :tables => true, :autolink => true, :gh_blockcode => true, :fenced_code_blocks => true
set :markdown_engine, :redcarpet

Time.zone = "Eastern Time (US & Canada)"

page "*", :layout => "application"

require "lib/helpers"
helpers IconHelpers

activate :i18n

configure :build do
  activate :minify_css
  activate :minify_javascript
end