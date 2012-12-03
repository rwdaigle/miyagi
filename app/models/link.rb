class Link < ActiveRecord::Base

  attr_accessible :url

  self.inheritance_column = "_not_used" # I'm using the type column, so tell Rails to bugger off

  before_validation :determine_type

  belongs_to :article
  
  def humanized_url
    hu = url.
      sub(/https?:\/\//, '').
      sub(/^github\.com\//, '').
      sub(/^www\./, '')
    return hu.slice(0, 50) + "..." if hu.size > 50
    hu
  end
  
  def humanized_type
    type.to_s.downcase
  end

  private

  def determine_type
    self.type = LinkTypeParser.type_of(url)
  end
  
end