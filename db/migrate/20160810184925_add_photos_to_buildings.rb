class AddPhotosToBuildings < ActiveRecord::Migration
  def change
    add_column :buildings, :photos, :json
  end
end
