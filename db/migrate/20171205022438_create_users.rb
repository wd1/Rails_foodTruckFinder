class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.text :f_name
      t.text :l_name
      t.text :username
      t.text :password_digest
      t.text :email
      t.integer :location_id

      t.timestamps
    end
  end
end
