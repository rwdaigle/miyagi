class User < ActiveRecord::Base

  class << self

    def create_anonymous_user
      User.create!
    end
  end
end