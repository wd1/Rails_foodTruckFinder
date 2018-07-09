class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.text :street_address
      t.text :city
      t.text :state
      t.text :zip
      t.integer :neighborhood_id

      t.timestamps
    end
  end
end
