class News < ActiveRecord::Base
  attr_accessible :guid, :title, :summary, :content, :image, :author, :published_at, :url, :category, :news_type, :source_id
  belongs_to :source

end
