require 'rails_helper'

RSpec.describe Cart, type: :model do

  attr_reader :cart

  before(:each) do
    @cart = Cart.new({"1" => 1})
  end
  
  it "has contents" do
    expect(cart.contents).to eq({"1" => 1})
  end

  it "can add items to cart" do
    cart.add_item(1)
    cart.add_item(2)
    
    expect(cart.contents).to eq({"1" => 2, "2" => 1})
  end

  it "can return how many of a particular item is has" do
    cart.add_item(1)

    expect(cart.count_of(1)).to eq 2
  end
end