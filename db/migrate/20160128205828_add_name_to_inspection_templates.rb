class AddNameToInspectionTemplates < ActiveRecord::Migration
  def change
    add_column :inspection_templates, :name, :string
  end
end
