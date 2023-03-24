class AddOperationalCostToTrading < ActiveRecord::Migration[7.0]
  def change
    add_column :tradings, :operation_cost, :float, default: 0
  end
end
