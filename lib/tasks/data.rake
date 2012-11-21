namespace :data do

  desc "Populate the database with a staging dataset"
  task :staging => [:environment, "db:migrate", "staging:authors", "staging:articles"]

  namespace :staging do

    task :reset => ["db:migrate:reset", "data:staging"]

    task :authors => :environment do
      [
        {
          first_name: "Ryan", last_name: "Smith", twitter_username: "ryandotsmith", gh_username: "ryandotsmith",
          site_url: "http://ryandotsmith.heroku.com/", profile: "Ryan Smith builds distributed systems at [Heroku](http://heroku.com). His writing is motivated by many success and failures experienced with production systems at Heroku."
        }
      ].each do |author_params|
        puts "Creating #{author_params[:twitter_username]}..."
        User.create!(author_params)
      end
    end

    task :articles => :environment do
      [
        ["ryandotsmith", "Process Partitioning in Distributed Systems", "https://raw.github.com/gist/4127005/12585f8d79c3c99a60f84701b0b15e621a1b019a/process-partitioning.md"]
      ].each do |content|
        puts "Fetching #{content[1]} content..."
        req = Curl.get(content[2])
        c = Article.create(:author => User.find_by_twitter_username(content[0]), :title => content[1], :body => req.body_str, :published_at => Time.now)
        puts c.errors.full_messages.join(", ") if !c.valid?
      end
    end
  end
end