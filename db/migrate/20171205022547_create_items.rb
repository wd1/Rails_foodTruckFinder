class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.text :name
      t.integer :price
      t.integer :truck_id

      t.timestamps
    end
  end
end
