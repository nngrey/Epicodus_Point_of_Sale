class ShoppingCart < ActiveRecord::Base
  has_many :purchases
  belongs_to :cashier
end
