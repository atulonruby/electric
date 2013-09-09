class CreateBlops < ActiveRecord::Migration
  def change
    create_table :blops do |t|
      t.string :title
      t.string :body

      t.timestamps
    end
  end
end
