require 'spec_helper'

describe ShoppingCart do
  it { should have_many :purchases }
  it { should belong_to :cashier }
end
