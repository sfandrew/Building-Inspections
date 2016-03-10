class AddScoreTypeToInspectionTemplateItems < ActiveRecord::Migration
  def change
    add_column :inspection_template_items, :score_type, :string
  end
end
