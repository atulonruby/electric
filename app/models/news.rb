class News < ActiveRecord::Base
  attr_accessible :body, :image, :title
  mount_uploader :image, NewsImageUploader
end
