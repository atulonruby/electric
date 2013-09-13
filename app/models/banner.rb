class Banner < ActiveRecord::Base
  attr_accessible :image, :width, :height
  mount_uploader :image, BanImageUploader
  
  before_save :save_image_dimensions
 


  private

    def save_image_dimensions
        self.width  = image.geometry[:width]
        self.height = image.geometry[:height]
    end
end
