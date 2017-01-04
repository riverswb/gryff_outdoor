require 'rails_helper'

RSpec.feature "When a user removes an item from their cart" do
  scenario "a message is displayed"
    create_list(:item, 10)
    item = Item.first
    cart = Cart.new({item.id => 1})

    visit cart_path(cart)
    click_on("Remove", match: :first)

    expect(current_path).to eq cart_path(cart)
    expect(page).to have_content "Successfully removed #{item.title} from your cart."
    expect(page).to have_link item_path(item)
  end
end