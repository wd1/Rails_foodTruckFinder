class CreateTrucks < ActiveRecord::Migration[5.1]
  def change
    create_table :trucks do |t|
      t.text :name
      t.integer :category_id

      t.timestamps
    end
  end
end
