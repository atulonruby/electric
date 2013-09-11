class ChangeStringToDate < ActiveRecord::Migration
  def change
     change_column :blopps, :body, :text
     change_column :news, :body, :text
  end
end

