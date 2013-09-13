class Picture < ActiveRecord::Base
  attr_accessible :description, :height, :image, :width
   mount_uploader :image, AllPicturesUploader
   before_save :save_image_dimensions



    private

      def save_image_dimensions
          self.width  = image.geometry[:width]
          self.height = image.geometry[:height]
      end
end
