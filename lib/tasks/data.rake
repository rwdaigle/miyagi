namespace :data do
  
  desc "Populate the database with a staging dataset"
  task :staging => :environment do
    [["Process Partitioning in Distributed Systems", "https://raw.github.com/gist/2374465/6eb4ed8904b9941c9070c76d420872a3c57f2649/process-partitioning.md"]].each do |article_data|
      puts "Fetching #{article_data[0]} content..."
      content = Curl.get(article_data[1])
      a = Article.create(:title => article_data[0], :body => content.body_str, :published_at => Time.now)
      puts a.errors.full_messages.join(", ") if !a.valid?
    end
  end
end