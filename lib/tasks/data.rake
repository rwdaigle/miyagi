namespace :data do

  desc "Populate the database with a staging dataset"
  task :staging => [:environment, "staging:articles", "staging:videos"]

  namespace :staging do

    task :articles => :environment do
      [
        ["Process Partitioning in Distributed Systems", "https://raw.github.com/gist/2374465/6eb4ed8904b9941c9070c76d420872a3c57f2649/process-partitioning.md"],
        ["The Worker Pattern", "https://raw.github.com/gist/2362143/635ad0fb9e9a0d1cc5f9559976a65d56d4cbd698/worker-pattern.md"]
      ].each do |content|
        puts "Fetching #{content[0]} content..."
        req = Curl.get(content[1])
        a = Article.create(:title => content[0], :body => req.body_str, :published_at => Time.now)
        puts a.errors.full_messages.join(", ") if !a.valid?
      end
    end

    task :videos => :environment do
      [
        ["Learn to Love Your Database", "http://vimeo.com/groups/waza2012/videos/49484558", "http://b.vimeocdn.com/ts/349/874/349874349_295.jpg"],
        ["Logs as Conversation", "http://vimeo.com/groups/waza2012/videos/49720072", "http://b.vimeocdn.com/ts/343/019/343019080_295.jpg"]
        ].each do |content|
          puts "Creating link to video: \"#{content[0]}...\""
          v = Video.create(:title => content[0], :target_url => content[1], :image_url => content[2], :published_at => Time.now)
          puts v.errors.full_messages.join(", ") if !v.valid?
      end
    end
  end
end