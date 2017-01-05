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

    expect(page).to have_content "Successfully removed #{items[0].title} from your cart."
    expect(page).to have_link items[0].title
  end
end