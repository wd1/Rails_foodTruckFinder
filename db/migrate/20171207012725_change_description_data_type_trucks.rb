class ChangeDescriptionDataTypeTrucks < ActiveRecord::Migration[5.1]
  def change
    change_column :trucks, :description, :text
  end
end
