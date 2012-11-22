# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


authors = [ {
  first_name: "Ryan", last_name: "Smith", twitter_username: "ryandotsmith", gh_username: "ryandotsmith",
  site_url: "http://ryandotsmith.heroku.com/", profile: "Ryan Smith builds distributed systems at [Heroku](http://heroku.com). His writing is motivated by many success and failures experienced with production systems at Heroku."
}]

authors.each do |author_params|
  puts "Creating #{author_params[:twitter_username]}..."
  m = User.create(author_params)
  puts m.errors.full_messages.join(', ') if !m.valid?
end

articles = [
  ["ryandotsmith", "Process Partitioning in Distributed Systems", "https://raw.github.com/gist/4127005/12585f8d79c3c99a60f84701b0b15e621a1b019a/process-partitioning.md"]
]

articles.each do |content|
  puts "Fetching #{content[1]} content..."
  req = Curl.get(content[2])
  m = Article.create(:author => User.find_by_twitter_username(content[0]), :title => content[1], :body => req.body_str, :published_at => Time.now)
  puts m.errors.full_messages.join(', ') if !m.valid?
end