class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :image
      t.integer :width
      t.integer :height
      t.text :description

      t.timestamps
    end
  end
end
