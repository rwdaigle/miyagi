require 'digest'

class User < ActiveRecord::Base

  attr_accessible :email, :subscribed, :first_name, :last_name, :twitter_username, :gh_username, :site_url, :profile

  validates :email, email: true, allow_nil: true, allow_blank: false, uniqueness: true
  validates :twitter_username, :gh_username, uniqueness: true, allow_nil: true

  has_many :comments

  before_save :generate_profile_html
  before_validation :generate_uuid

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
    { user_id: id, user_uuid: uuid }
  end

  private

  def generate_profile_html
    self.profile_html = MarkdownRenderer.to_html(profile) if !profile.blank?
  end

  def generate_uuid
    if(!uuid)
      seed = "#{Time.now.to_i.to_s}-#{SecureRandom.uuid}"
      self.uuid = Digest::SHA1.hexdigest(seed)
    end
  end
end