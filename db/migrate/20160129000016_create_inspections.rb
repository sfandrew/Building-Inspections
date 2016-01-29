class CreateInspections < ActiveRecord::Migration
  def change
    create_table :inspections do |t|
      t.text :description
      t.integer :unit_id
      t.string :status

      t.timestamps null: false
    end
  end
end
