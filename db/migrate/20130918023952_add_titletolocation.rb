class AddTitletolocation < ActiveRecord::Migration
  def change
     add_column :locations, :title, :string
     add_column :locations, :date, :datetime
     change_column :locations, :description, :text
  end
end
