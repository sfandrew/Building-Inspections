class AddNameToInspectionTemplateItem < ActiveRecord::Migration
  def change
    add_column :inspection_template_items, :name, :string
  end
end
