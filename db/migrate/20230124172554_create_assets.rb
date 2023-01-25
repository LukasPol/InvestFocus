class CreateAssets < ActiveRecord::Migration[7.0]
  def change
    create_table :assets, id: :uuid, bulk: true do |t|
      t.integer :amount, default: 0
      t.float :average_price, default: 0
      t.float :total_invested, default: 0
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :stock, null: false, foreign_key: true, type: :uuid
      t.index [:stock_id, :user_id], unique: true

      t.timestamps
    end
  end
end
