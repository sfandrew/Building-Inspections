class RemoveScoreAndAddRawScoreToInspectionItems < ActiveRecord::Migration
  def up
    add_column :inspection_items, :score_type, :string
    add_column :inspection_items, :raw_score, :string
    remove_column :inspection_items, :score
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
