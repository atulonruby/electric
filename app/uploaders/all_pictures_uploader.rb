# encoding: utf-8

class AllPicturesUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
   include Sprockets::Helpers::RailsHelper
   include Sprockets::Helpers::IsolatedHelper
   storage :fog
   include CarrierWave::MimeTypes
   process :set_content_type

   def store_dir
     "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
   end

   version :thumb do
     process :resize_to_limit => [330, 10000]
   end

   version :large do
     process :resize_to_limit => [1000,10000]
   end


   def geometry
       @geometry ||= get_geometry
     end

   def get_geometry
     if @file
      img = ::Magick::Image::read(@file.file).first
      geometry = { width: img.columns, height: img.rows }
     end
    end


end
