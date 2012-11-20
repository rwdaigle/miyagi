class Link < ActiveRecord::Base

  attr_accessible :url

  belongs_to :article
end