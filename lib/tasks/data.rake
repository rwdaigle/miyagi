namespace :data do

  desc "Populate the database with a staging dataset"
  task :staging => [:environment, "db:migrate", "staging:articles"]

  namespace :staging do

    task :reset => ["db:migrate:reset", "data:staging"]

    task :articles => :environment do
      [
        ["Process Partitioning in Distributed Systems", "https://raw.github.com/gist/4127005/12585f8d79c3c99a60f84701b0b15e621a1b019a/process-partitioning.md"]
      ].each do |content|
        puts "Fetching #{content[0]} content..."
        req = Curl.get(content[1])
        c = Article.create(:title => content[0], :body => req.body_str, :published_at => Time.now)
        puts c.errors.full_messages.join(", ") if !c.valid?
      end
    end
  end
end