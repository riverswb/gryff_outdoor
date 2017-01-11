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
    cart.add_item(items[0].id)
    cart.add_item(items[1].id)
    
    expect(cart.contents).to eq({items[0].id.to_s => 2, items[1].id.to_s => 1})
  end

  it "can return how many of a particular item is has" do
    cart.add_item(items[0].id)

    expect(cart.count_of(items[0].id)).to eq 2
  end

  it "can return the total price of all items in cart" do
    total = cart.contents.inject(0) do |sum, item_id|
      item = Item.find(item_id[0])
      sum += item.price * item_id[1]
      sum
    end

    expect(cart.total_cost).to eq total
  end

  it "can remove item from cart" do
    expect(cart.contents).to eq({items[0].id.to_s => 1})
    cart.remove(items[0].id)

    expect(cart.contents).to eq({})
  end

  it "can reduce the quanity of a specific item by one" do
    cart.add_item(items[0].id)
    cart.remove(items[0].id)

    expect(cart.contents).to eq({items[0].id.to_s => 1})
  end

  it "can tell whether to increase or deacrease the quantity" do
    cart.change_quantity(items[0].id, "increase")

    expect(cart.contents).to eq({items[0].id.to_s => 2})

    cart.change_quantity(items[0].id, "decrease")
    
    expect(cart.contents).to eq({items[0].id.to_s => 1})
  end
end