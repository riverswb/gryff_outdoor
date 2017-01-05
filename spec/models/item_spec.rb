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
end
