class Blop < ActiveRecord::Base
  attr_accessible :body, :title, :blog_image
  has_attached_file :blog_image, :styles => {:small => "200x200", :medium => "400x400" }
 validates_attachment :blog_image, size: { less_than: 5.megabytes}
end
