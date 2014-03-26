class Cashier < ActiveRecord::Base
  has_many(:shopping_carts)
end
