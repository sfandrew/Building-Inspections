class AddSectionsToInspections < ActiveRecord::Migration
  def change
    add_column :inspections, :sections, :text
  end
end
