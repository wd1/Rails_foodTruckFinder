class AddLocationToTruck < ActiveRecord::Migration[5.1]
  def change
    add_column :trucks, :location_id, :integer
  end
end
