class CreateInspectionTemplates < ActiveRecord::Migration
  def change
    create_table :inspection_templates do |t|
      t.integer :unit_id

      t.timestamps null: false
    end
  end
end
