class Feed < ActiveRecord::Base
  attr_accessible :image, :name, :limit, :status, :url
  belongs_to :source
end
