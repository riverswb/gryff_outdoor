require 'rails_helper'

RSpec.feature "When a users visits orders path" do

  attr_reader :items

  before(:all) do
    @items = create_list(:item, 10)
  end
  scenario "they see all orders belonging to them" do

    user = create(:user)
    visit login_path
    fill_in "Email", :with => user.Email
    fill_in "Password", :with => user.Password

    visit item_path(items[0])
    click_button "Add Item"

    click_on "View Cart"
    click_on "Checkout"

    visit item_path(items[1])
    click_button "Add Item"
    click_button "Add Item"
    total_price = items[1] + items[1]
    click_on "View Cart"
    click_on "Checkout"

    visit order_path

    expect(page).to have_content "Order 1"
    expect(page).to have_content "Order 1"
    expect(page).to_no have_content "Order 3"
    expect(page).to have_content "1 item"
    expect(page).to have_content "2 items"
    expect(page).to have_content total_price
  end
end