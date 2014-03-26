require 'active_record'
require 'shoulda-matchers'
require 'rspec'

require 'cashier'
require 'purchase'
require 'product'
require 'shopping_cart'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.after(:each) do
    Cashier.all.each { |cashier| cashier.destroy }
    Product.all.each { |product| product.destroy }
    Purchase.all.each { |purchase| purchase.destroy }
    ShoppingCart.all.each { |shopping_cart| shopping_cart.destroy }
  end
end
