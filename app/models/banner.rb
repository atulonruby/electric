class Banner < ActiveRecord::Base
  attr_accessible :image
  mount_uploader :image, NewsImageUploader
end
