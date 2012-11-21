class User < ActiveRecord::Base

  attr_accessible :email, :subscribed, :first_name, :last_name, :twitter_username, :gh_username, :site_url, :profile

  validates :email, email: true, allow_nil: true, allow_blank: false

  has_many :comments

  before_save :generate_profile_html

  class << self

    def create_anonymous_user
      User.create!
    end
  end

  def subscribe!(email)
    update_attributes(email: email, subscribed: true)
  end

  def name
    "#{first_name} #{last_name}"
  end

  def to_log
    { user_id: id }
  end

  private

  def generate_profile_html
    self.profile_html = MarkdownRenderer.to_html(profile)
  end
end