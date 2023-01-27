class AddIndexToStockCode < ActiveRecord::Migration[7.0]
  def change
    add_index :stocks, :code, unique: true
  end
end
