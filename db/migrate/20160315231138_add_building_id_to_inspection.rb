class AddBuildingIdToInspection < ActiveRecord::Migration
  def change
    add_column :inspections, :building_id, :integer
  end
end
