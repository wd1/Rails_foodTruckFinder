class AddDescriptionToTruck < ActiveRecord::Migration[5.1]
  def change
    add_column :trucks, :description, :string  
  end
end
