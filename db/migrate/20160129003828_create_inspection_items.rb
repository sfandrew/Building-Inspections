class CreateInspectionItems < ActiveRecord::Migration
  def change
    create_table :inspection_items do |t|
      t.string :name
      t.decimal :weight
      t.integer :position
      t.string :section
      t.decimal :score
      t.text :comment
      t.string :type
      t.string :status
      t.integer :inspection_id

      t.timestamps null: false
    end
  end
end
