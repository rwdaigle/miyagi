namespace :data do

  desc "Populate the database with a staging dataset"
  task :staging => [:environment, "db:migrate", "staging:articles"]

  namespace :staging do

    task :reset => ["db:reset", "data:staging"]

    task :articles => :environment do
      [
        ["Process Partitioning in Distributed Systems", "https://raw.github.com/gist/2374465/6eb4ed8904b9941c9070c76d420872a3c57f2649/process-partitioning.md"],
        ["The Worker Pattern", "https://raw.github.com/gist/2362143/635ad0fb9e9a0d1cc5f9559976a65d56d4cbd698/worker-pattern.md"]
      ].each do |content|
        puts "Fetching #{content[0]} content..."
        req = Curl.get(content[1])
        c = Article.create(:title => content[0], :body => req.body_str, :published_at => Time.now)
        puts c.errors.full_messages.join(", ") if !c.valid?
      end
    end
  end
end