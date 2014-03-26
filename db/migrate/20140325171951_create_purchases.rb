class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.column :cashier_id, :integer
      t.column :product_id, :integer

      t.timestamps
    end
  end
end
