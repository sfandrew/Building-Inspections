class CreateInspectionTemplateItems < ActiveRecord::Migration
  def change
    create_table :inspection_template_items do |t|
      t.string :type
      t.string :section
      t.decimal :weight
      t.integer :position
      t.integer :inspection_template_id

      t.timestamps null: false
    end
  end
end
