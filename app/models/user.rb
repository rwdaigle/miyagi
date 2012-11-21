class User < ActiveRecord::Base

  attr_accessible :email, :subscribed

  validates :email, email: true, allow_nil: true, allow_blank: false

  class << self

    def create_anonymous_user
      User.create!
    end
  end

  def subscribe!(email)
    update_attributes(email: email, subscribed: true)
  end
end