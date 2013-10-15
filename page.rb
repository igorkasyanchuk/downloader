class Page < ActiveRecord::Base
  attr_accessible :url, :content, :created_on, :status

  validates_uniqueness_of :url
end
