class CreateProceeds < ActiveRecord::Migration[7.0]
  def change
    create_table :proceeds, id: :uuid do |t|
      t.integer :amount, default: 0
      t.integer :kind, default: 0
      t.float :value_unit, default: 0
      t.float :total_value, default: 0
      t.date :date
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :asset, null: false, foreign_key: true, type: :uuid
      t.references :stock, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
