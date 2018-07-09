class AddImgUrlToTrucks < ActiveRecord::Migration[5.1]
  def change
    add_column :trucks, :img_url, :text
  end
end
