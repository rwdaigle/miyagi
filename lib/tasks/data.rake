namespace :data do

  desc "Remove all data from the database, and re-seed from scratch"
  task :refresh => [:environment, "data:clear", "db:seed"]

  desc "Remove all data from the database"
  task :clear => :environment do
    [User, Article, Comment, Link].each do |model|
      puts "Removing all #{model.to_s.downcase.pluralize}"
      model.delete_all
    end
  end
end