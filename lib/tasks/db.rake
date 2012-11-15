namespace :db do

  desc "Reset the database"
  task :reset => [:environment, "db:drop", "db:create"]
end