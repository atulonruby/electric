class AddWidthAndHeightToBannerTable < ActiveRecord::Migration
  def change
    add_column :banners, :width, :integer
    add_column :banners, :height, :integer
  end
end
