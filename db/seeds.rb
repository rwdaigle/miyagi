# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


authors = [ {
  first_name: "Ryan", last_name: "Smith", twitter_username: "ryandotsmith", gh_username: "ryandotsmith",
  site_url: "http://ryandotsmith.heroku.com/", profile: "Ryan builds distributed systems at [Heroku](http://heroku.com). His writing is motivated by many successes and failures experienced with production systems at Heroku."
}, {
  first_name: "Pedro", last_name: "Belo", twitter_username: "ped", gh_username: "pedro",
  site_url: "http://pedro.herokuapp.com/", profile: "Pedro is a proponent of shipping, improving and avoiding code. Current obsessions include: APIs, distributed architectures, zero downtime deploys and [caipirinhas](http://en.wikipedia.org/wiki/Caipirinha)."
}]

authors.each do |author_params|
  puts "Creating #{author_params[:twitter_username]}..."
  m = User.create(author_params)
  puts m.errors.full_messages.join(', ') if !m.valid?
end

abd_summary = "Automated testing is a proven tool for verifying application behavior and preventing bugs and regressions. However, as a last-minute line of defense, testing can often be eschewed in favor of baking preventative behavior directly into the application design."
ppds_summary = "Assigning a group of worker processes to operate, in parallel, against a large dataset is a very efficient approach to data processing. Process partitioning is a scalable approach for coordinating work across a pool of independent workers."

articles = [
  ["ped", "Assertions by Design", "https://raw.github.com/gist/bf2e720a2d045cd70725/assertions.md", abd_summary],
  ["ryandotsmith", "Process Partitioning in Distributed Systems", "https://raw.github.com/gist/4127005/process-partitioning.md", ppds_summary]
]

articles.each do |content|
  puts "Fetching #{content[1]} content..."
  req = Curl.get(content[2])
  m = Article.create(:author => User.find_by_twitter_username(content[0]), :summary => content[3], :title => content[1], :body => req.body_str, :published_at => Time.now)
  puts m.errors.full_messages.join(', ') if !m.valid?
end