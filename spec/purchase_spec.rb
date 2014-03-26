require 'spec_helper'

describe Purchase do
  it { should belong_to :product }
  it { should belong_to :shopping_cart }
end
