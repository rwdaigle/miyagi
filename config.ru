require 'rubygems'
require 'bundler/setup'

Bundler.require(ENV['RACK_ENV'])

unless ENV['RACK_ENV'] == 'production'
  use Rack::ShowExceptions
end

ttl = ENV['DEFAULT_TTL'] ? ENV['DEFAULT_TTL'].to_i : 3600

use Rack::Cache,
  :verbose     => true,
  :default_ttl => ttl,
  :allow_reload => true,
  :allow_revalidate => true,
  :private_headers => [],
  :metastore   => "memcached://#{ENV['MEMCACHE_SERVERS'] || 'localhost:11211'}/meta",
  :entitystore => "memcached://#{ENV['MEMCACHE_SERVERS'] || 'localhost:11211'}/meta"

use Rack::ResponseHeaders do |headers|
  headers['Cache-Control'] = "public, max-age=#{ttl}"
end

use Rack::CommonLogger
use Rack::ETag

require 'rack/contrib/try_static'

use Rack::TryStatic,
    :root => "site",
    :urls => %w[/],
    :try => ['.html', 'index.html', '/index.html']

run lambda { [404, {'Content-Type' => 'text/html'}, ['Not Found']]}

# use Rack::Rewrite do
#   # rewrite '/', '/index.html'
# end

# # use Rack::Rewrite do
# #   r307 %r{^([^\.]*[^\/])$}, '$1/' 
# #   r307 %r{^(.*\/)$}, '$1index.html'
# # end

# run Rack::Directory.new('public')

# # use Rack::Static, 
# #   :urls => ["/images", "/javascripts", "/stylesheets", "/fonts", "/articles"],
# #   :root => "public"

# # run lambda { |env|
# #   [
# #     200, 
# #     {
# #       'Content-Type'  => 'text/html', 
# #       'Cache-Control' => 'public, max-age=#{ttl}' 
# #     },
# #     File.open('public/index.html', File::RDONLY)
# #   ]
# # }