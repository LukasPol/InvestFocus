class AddProceedReceivedToAssets < ActiveRecord::Migration[7.0]
  def change
    add_column :assets, :proceed_received, :float, default: 0
  end
end
