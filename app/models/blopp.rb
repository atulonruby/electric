class Blopp < ActiveRecord::Base
  attr_accessible :body, :image, :title, :remote_image_url
  mount_uploader :image, BlogUploader
end
