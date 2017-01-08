require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a title" do
        invalid_item = Item.new(title: nil, description: "tree description",
                                price: 99.95, image: "tree-picture.com")

        expect(invalid_item).to be_invalid
      end

      it "is invalid without a description" do
        invalid_item = Item.new(title: "tree", description: nil,
                                price: 99.95, image: "tree-picture.com")

        expect(invalid_item).to be_invalid
      end

      it "is invalid without a price" do
        invalid_item = Item.new(title: "tree", description: "tree description",
                                price: nil, image: "tree-picture.com")

        expect(invalid_item).to be_invalid
      end

      it "is invalid without an image" do
        invalid_item = Item.new(title: "tree", description: "tree description",
                                price: 99.95, image: nil)

        expect(invalid_item).to be_invalid
      end
    end
  end
  describe 'status' do
    it "has a status" do
      item = create(:item)

      expect(item).to respond_to(:status)  
    end

    it "defaults to 'active'" do
      item = create(:item)

      expect(item.status).to eq("active")
    end

    it "can be set to 'retired'" do
      item = create(:item, status: 1)

      expect(item.status).to eq("retired")
    end
  end
end
