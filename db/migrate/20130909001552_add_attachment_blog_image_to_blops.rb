class AddAttachmentBlogImageToBlops < ActiveRecord::Migration
  def self.up
    change_table :blops do |t|
      t.attachment :blog_image
    end
  end

  def self.down
    drop_attached_file :blops, :blog_image
  end
end
