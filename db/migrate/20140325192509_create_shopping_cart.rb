class CreateShoppingCart < ActiveRecord::Migration
  def change
    create_table :shopping_carts do |t|
      t.column :cashier_id, :integer
      t.column :date, :timestamp
      t.column :total, :decimal, precision: 5, scale: 2

      t.timestamps
    end
  end
end
