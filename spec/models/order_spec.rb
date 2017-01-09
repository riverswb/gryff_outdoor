require 'rails_helper'

RSpec.describe Order, type: :model do

  attr_reader :order

  before(:each) do
    @order = create:order
  end

  describe "relationships" do
    it { should belong_to(:user)}
    it { should have_many(:order_items)}
    it { should have_many(:items)}
  end

  describe "calculations" do
    it "can count the amount of items it has" do
      expect(order.count).to eq 5
    end
  



  end
end