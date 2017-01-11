require 'rails_helper'

RSpec.describe Order, type: :model do

  attr_reader :order, :items

  before(:each) do
    @order = create(:order)
    @items = create_list(:item, 10)
  end

  describe "relationships" do
    it { should belong_to(:user)}
    it { should belong_to(:address)}
    it { should have_many(:order_items)}
    it { should have_many(:items)}
  end

  describe "calculations" do
    it "can count the amount of all its' items" do
      expect(order.count).to eq 5
    end

    it "can calculate the total price of all its items" do
      total_price = order.items.inject(0) {|sum, item| sum += item.price}
      
      expect(order.total_price).to eq total_price
    end
  
    it "can return a special message if the status is completed" do
      order = create(:order, status: 3)
      
      expect(order.canceled_or_completed).to eq "Completed at #{order.updated_at}"
    end

    it "can return a special message if the status is cancelled" do
      order = create(:order, status: 2)

      expect(order.canceled_or_completed).to eq "Cancelled at #{order.updated_at}"
    end

    it "can make an order" do
      expect(order.count).to eq 5
      Order.make_order(order, {items[0].id.to_s => 2, items[1].id.to_s => 1})
    
      expect(order.count).to eq 8
    end

    it "can add an item" do
      expect(order.count).to eq 5
      order.add_item(items[0].id, 5)
      
      expect(order.count).to eq 10
    end
  end
end