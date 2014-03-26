class AddColumnShoppingCartId < ActiveRecord::Migration
  def change
    add_column :purchases, :shopping_cart_id, :integer
  end
end
