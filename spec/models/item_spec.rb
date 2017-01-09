require 'rails_helper'

RSpec.describe Item, type: :model do

  attr_reader  :item

  before(:each) do
    @item = create(:item)
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:title)}
    it { is_expected.to validate_presence_of(:description)}
    it { is_expected.to validate_presence_of(:price)}
    it { is_expected.to validate_presence_of(:image)}
  end
  
  describe "relationships" do
    it { should belong_to(:category)}
    it { should have_many(:order_items)}
  it { should have_many(:orders)}
  end

  describe 'status' do
    it "has a status" do
      expect(item).to respond_to(:status)  
    end

    it "defaults to 'active'" do
      expect(item.status).to eq("active")
    end

    it "can be set to 'retired'" do
      item = create(:item, status: 1)
      expect(item.status).to eq("retired")
    end
  end
end
