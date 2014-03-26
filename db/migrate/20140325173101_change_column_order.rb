class ChangeColumnOrder < ActiveRecord::Migration
  def change
    change_column :purchases, :quantity, :integer, after: :product_id
  end
end
