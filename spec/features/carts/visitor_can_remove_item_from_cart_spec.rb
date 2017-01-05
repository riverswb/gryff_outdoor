require 'rails_helper'

RSpec.feature "When a user removes an item from their cart" do
  scenario "a message is displayed" do
    items = create_list(:item, 10)
    visit item_path(items[0])
    click_on "Add Item"
    click_on "Add Item"
      visit item_path(items[1])
    click_on "Add Item"
      visit item_path(items[2])
    click_on "Add Item"
    click_on "View Cart"

    click_on("Remove", match: :first)
    binding.pry
    expect(current_path).to eq cart_path
    expect(page).to have_content "Successfully removed #{item.title} from your cart."
    expect(page).to have_link item_path(item)
  end
end