class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.references :building, index: true, foreign_key: true
      t.string :unit_number

      t.timestamps null: false
    end
  end
end
