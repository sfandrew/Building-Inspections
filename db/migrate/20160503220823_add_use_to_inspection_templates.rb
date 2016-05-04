class AddUseToInspectionTemplates < ActiveRecord::Migration
  def change
    add_column :inspection_templates, :user_id, :integer
  end
end
