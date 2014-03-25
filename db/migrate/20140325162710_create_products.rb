class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.column :name, :string
      t.column :price, :decimal, precision: 5, scale: 2

      t.timestamps
    end
  end
end
