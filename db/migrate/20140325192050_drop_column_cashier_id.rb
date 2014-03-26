class DropColumnCashierId < ActiveRecord::Migration
  def change
    remove_column :purchases, :cashier_id, :integer
  end
end
