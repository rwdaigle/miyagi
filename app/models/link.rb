class Link < ActiveRecord::Base

  TYPE_GITHUB = "GITHUB"
  TYPE_PAGE = "PAGE"

  attr_accessor :host
  attr_accessible :url, :host

  self.inheritance_column = "_not_used" # I'm using the type column, so tell Rails to bugger off

  before_validation :determine_type

  belongs_to :article

  private

  # TODO: Pull out to more flexible regex-based matching approach
  def determine_type
    self.type = host.ends_with?("github.com") ? TYPE_GITHUB : TYPE_PAGE
  end
end