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
    :root => "build",
    :urls => %w[/],
    :try => ['.html', 'index.html', '/index.html']

run lambda { [404, {'Content-Type' => 'text/html'}, ['Not Found']]}