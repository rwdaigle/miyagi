namespace :data do

  desc "Populate the database with a staging dataset"
  task :staging => [:environment, "staging:articles", "staging:events", "staging:projects", "staging:pages", "staging:videos"]

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

    task :pages => :environment do
      [
        ["Go by Example", "https://gobyexample.com/", "http://golang.org/doc/gopher/frontpage.png", "Go is an open source programming language designed for building simple, fast, and reliable software. Go by Example is a hands-on introduction to Go using annotated example programs."],
        ["UT on Rails", "http://schneems.com/ut-rails", "http://24.media.tumblr.com/avatar_0ba95ae772c3_128.png", "Last year I held a series of non credit Rails courses for University of Texas Students, I'm happy to announce that I've been granted an Adjunct Professor position at the UT and I'm teaching a for credit course in Databases and Rails. Lucky for you, I'm a sucker for online learning, so I'll be putting all my course material online."]
        ].each do |content|
          puts "Creating link to page: \"#{content[0]}...\""
          c = Page.create(:title => content[0], :target_url => content[1], :image_url => content[2], :summary => content[3], :published_at => Time.now)
          puts c.errors.full_messages.join(", ") if !c.valid?
      end
    end

    task :videos => :environment do
      [
        ["Learn to Love Your Database", "http://vimeo.com/groups/waza2012/videos/49484558", "http://b.vimeocdn.com/ts/349/874/349874349_295.jpg"],
        ["Logs as Conversation", "http://vimeo.com/groups/waza2012/videos/49720072", "http://b.vimeocdn.com/ts/343/019/343019080_295.jpg"]
        ].each do |content|
          puts "Creating link to video: \"#{content[0]}...\""
          c = Video.create(:title => content[0], :target_url => content[1], :image_url => content[2], :published_at => Time.now)
          puts c.errors.full_messages.join(", ") if !c.valid?
      end
    end

    task :projects => :environment do
      [
        ["Datascope", "https://github.com/will/datascope", "https://a248.e.akamai.net/camo.github.com/03a70dce9016202f095225fb67cd5c7d57276138/687474703a2f2f662e636c2e6c792f6974656d732f3434305a314c316e3276337133633151334a30732f6461746173636f70652e706e67", "Postgres 9.2 visibility."],
        ["f-lock", "https://github.com/ryandotsmith/f-lock", nil, "A water lock for internet protocol data flow"],
        ["rack-core-data", "https://github.com/mattt/rack-core-data", nil, "Automatically generate REST APIs from Core Data models."]
        ].each do |content|
          puts "Creating link to project: \"#{content[0]}...\""
          c = Project.create(:title => content[0], :target_url => content[1], :image_url => content[2], :summary => content[3], :published_at => Time.now)
          puts c.errors.full_messages.join(", ") if !c.valid?
      end
    end

    task :events => :environment do
      [
        ["Waza", "http://waza.heroku.com/", "http://waza.heroku.com/assets/logo-waza.png", "Heroku's developer event"]
        ].each do |content|
          puts "Creating link to event: \"#{content[0]}...\""
          c = Event.create(:title => content[0], :target_url => content[1], :image_url => content[2], :summary => content[3], :published_at => Time.now)
          puts c.errors.full_messages.join(", ") if !c.valid?
      end
    end
  end
end