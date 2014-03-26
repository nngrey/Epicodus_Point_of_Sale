require 'active_record'
require './lib/cashier'
require './lib/product'
require './lib/shopping_cart'
require './lib/purchase'
require 'pry'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])

def welcome
  puts "Welcome to the POS system"
  menu
end

def menu
  choice = nil
  until choice == 'e'
    puts "Press 'm' if you are a store manager"
    puts "Press 'c' if you are a cashier"
    puts "Press 'p' if you are a customer"
    puts "Press 'e' to exit the system"
    employee = gets.chomp
    case employee
    when 'm'
      manager
    when 'c'
      cashier
    when 'p'
      customer
    when 'e'
      puts "Good-bye"
      exit
    else
      puts "Please select a valid option"
    end
  end
end

def manager
  choice = nil
  until choice =='e'
    puts "Press 'c' to add a new cashier"
    puts "Press 'p' to add a new product"
    puts "Press 'e' to revert back to the main menu"
    manager_input = gets.chomp
    case manager_input
    when 'c'
      add_cashier
    when 'p'
      add_product
    when 'e'
      menu
    else
      puts "Please select a valid option"
    end
  end
end

def add_cashier
  puts "Enter the name of the cashier:"
  cashier_name = gets.chomp
  new_cashier = Cashier.new(:name => cashier_name)
  new_cashier.save
  puts "You have added #{Cashier.where(:name => cashier_name).first['name']}"
end

def add_product
  puts "Enter the name of the product you would like to add to the store's inventory"
  product_name = gets.chomp
  puts "What is the price of #{product_name}?"
  product_price = gets.chomp
  new_product = Product.new(:name => product_name,:price => product_price)
  new_product.save
  puts "You have added #{Product.where(:name => product_name).first['name']} at the price of $#{Product.where(:name => product_name).first['price']}"
end

def cashier(shopping_cart)
  puts "To login, please enter your name from the list of cashiers:"
  cashiers = Cashier.all
  cashiers.each { |cashier| puts cashier.name }
  cashier_name = gets.chomp
  cashier_id = Cashier.where(:name => cashier_name).first['id']
  shopping_cart.cashier_id = cashier_id
  shopping_cart.save
  puts "My name is #{Cashier.find(cashier_id).name}"
  puts "Here's your order"
  purchases = Purchase.where(:shopping_cart_id => shopping_cart.id)
  purchases.each do |purchase|
    pid = purchase['product_id']
    puts Product.find(pid).name
  end
  puts "Here's your total $#{shopping_cart.total}"
  menu
end

def add_item
  puts "Select which product to add to the customer's purchase"
  products = Product.all
  products.each { |product| puts product.name }
  product_name = gets.chomp
  product_id = Product.where(:name => product_name).first['id']

  puts "Enter the quantity being purchased"
  quantity = gets.chomp
  new_purchase = Purchase.new(:cashier_id => cashier_id, :product_id => product_id, :quantity => quantity)

  puts "#{new_purchase.quantity} #{Product.find(product_id).name} have been added"
end

def customer
  shopping_cart = ShoppingCart.new
  shopping_cart.save
  shopping_cart_id = shopping_cart.id
  add_item(shopping_cart)
end

def add_item(shopping_cart)
  choice = nil
  new_total = 0
  until choice == 'e'
    puts "Press 'a' to add an item"
    puts "Press 'e' to checkout"

    user_choice = gets.chomp
    case user_choice
    when 'a'
    puts 'Enter an item name to add it to your shopping cart'
    products = Product.all
    products.each { |product| puts product.name }
    product_name = gets.chomp
    product_id = Product.where(:name => product_name).first['id']

    puts "Enter the quantity being purchased"
    quantity = gets.chomp
    new_purchase = Purchase.new(:shopping_cart_id => shopping_cart.id, :product_id => product_id, :quantity => quantity)
    new_purchase.save

    puts "#{new_purchase.quantity} #{Product.find(product_id).name} have been added"
    subtotal = Product.find(product_id).price * quantity.to_i
    # binding.pry
    # total = shopping_cart.total
    new_total = new_total + subtotal
    # binding.pry

    shopping_cart.total = new_total
    shopping_cart.save
    when 'e'
      cashier(shopping_cart)
    else
      puts "Please make a valid entry"
    end
  end
end
welcome
