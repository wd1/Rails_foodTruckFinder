class CreateSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :schedules do |t|
      t.date :date
      t.integer :truck_id
      t.integer :location_id

      t.timestamps
    end
  end
end
