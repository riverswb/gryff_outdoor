require 'rails_helper'

RSpec.describe Cart, type: :model do

  attr_reader :cart,
              :items

  before(:each) do
    @items = create_list(:item, 10)
    @cart = Cart.new({items[0].id.to_s => 1})
  end
  
  it "has contents" do
    expect(cart.contents).to eq({items[0].id.to_s => 1})
  end

  it "can add items to cart" do
    cart.add_item(items[0].id.to_s)
    cart.add_item(items[1].id.to_s)
    
    expect(cart.contents).to eq({items[0].id.to_s => 2, items[1].id.to_s => 1})
  end

  it "can return how many of a particular item is has" do
    cart.add_item(items[0].id.to_s)

    expect(cart.count_of(items[0].id)).to eq 2
  end

  it "can return the total price of all items in cart" do
    cart.contents.inject(0) do |sum, item_id|
      item = Item.find(item_id[0])
      sum += item.price
      sum
    end

    expect(cart.total_cost).to eq total
  end
end