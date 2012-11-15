namespace :data do

  desc "Populate the database with a staging dataset"
  task :staging => [:environment, "db:migrate", "staging:articles", "staging:linked"]

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

    task :linked => :environment do
      [
        ["UT on Rails", "http://schneems.com/ut-rails", "http://24.media.tumblr.com/avatar_0ba95ae772c3_128.png", "Last year I held a series of non credit Rails courses for University of Texas Students, I'm happy to announce that I've been granted an Adjunct Professor position at the UT and I'm teaching a for credit course in Databases and Rails. Lucky for you, I'm a sucker for online learning, so I'll be putting all my course material online."],
        ["Waza", "http://waza.heroku.com/", "http://waza.heroku.com/assets/logo-waza.png", "Heroku's developer event"],
        ["f-lock", "https://github.com/ryandotsmith/f-lock", nil, "A water lock for internet protocol data flow"],
        ["A Philosophy of Restraint", "https://speakerdeck.com/colly/a-philosophy-of-restraint", "http://f.cl.ly/items/1U2U163n3o2H38411I0C/Image%202012-11-15%20at%2010.10.00%20AM.png", "With a wealth of ideas and tools at our disposal, we often muddle our messages and complicate our code. We appreciate that less is usually more, yet stuff our sites to bursting point, failing to be economical with what we have. We must know when to stop, and when to throw things out. We should embrace simplicity and subtlety, and exploit the invisible."],
        ["What Every Programmer Should Know About Distributed Systems", "http://www.slideshare.net/pedrobelo/what-every-programmer-should-know-about-distributed-systems", nil, "It's time to talk about distributed systems: what are they, why you should be writing one, and what to look for while doing so. We'll cover the basics, understand some of the technology behind it - like REST, MQ with AMQP, ZeroMQ, etc - and discuss things we're doing at Heroku to avoid the pitfalls of a distributed architecture."],
        ["Logs as Conversation", "http://vimeo.com/groups/waza2012/videos/49720072", "http://b.vimeocdn.com/ts/343/019/343019080_295.jpg"],
        ["Datascope", "https://github.com/will/datascope", "https://a248.e.akamai.net/camo.github.com/03a70dce9016202f095225fb67cd5c7d57276138/687474703a2f2f662e636c2e6c792f6974656d732f3434305a314c316e3276337133633151334a30732f6461746173636f70652e706e67", "Postgres 9.2 visibility."],
        ["Go by Example", "https://gobyexample.com/", "http://golang.org/doc/gopher/frontpage.png", "Go is an open source programming language designed for building simple, fast, and reliable software. Go by Example is a hands-on introduction to Go using annotated example programs."],
        ["rack-core-data", "https://github.com/mattt/rack-core-data", nil, "Automatically generate REST APIs from Core Data models."],
        ["The Twelve-factor App", "http://www.12factor.net/", "http://www.12factor.net/images/symbol.png", "In the modern era, software is commonly delivered as a service: called web apps, or software-as-a-service. The twelve-factor app is a methodology for building software-as-a-service apps."],
        ["Learn to Love Your Database", "http://vimeo.com/groups/waza2012/videos/49484558", "http://b.vimeocdn.com/ts/349/874/349874349_295.jpg"],
      ].each do |content|
          puts "Creating link to: \"#{content[0]}...\""
          c = LinkedContent.create(:title => content[0], :target_url => content[1], :image_url => content[2], :summary => content[3], :published_at => Time.now)
          puts c.errors.full_messages.join(", ") if !c.valid?
      end
    end
  end
end