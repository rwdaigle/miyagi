class Link < ActiveRecord::Base

  attr_accessible :url

  self.inheritance_column = "_not_used" # I'm using the type column, so tell Rails to bugger off

  before_validation :determine_type

  belongs_to :article

  private

  def determine_type
    self.type = LinkTypeParser.type_of(url)
  end
end