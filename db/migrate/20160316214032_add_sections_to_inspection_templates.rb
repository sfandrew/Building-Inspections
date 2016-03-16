class AddSectionsToInspectionTemplates < ActiveRecord::Migration
  def change
    add_column :inspection_templates, :sections, :text
  end
end
