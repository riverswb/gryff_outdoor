require 'rails_helper'

RSpec.feature 'Visitor is required to login to account before checkout', type: :feature do

  scenario "an existing user and a cart with items" do
    user = create(:user)
    item = create(:item)

    visit item_path(item)
    click_on "Add Item"
    click_on "Add Item"
    click_on "View Cart"
    click_on "Login or Create Account to Checkout"

    fill_in 'email', with: user.email
    fill_in 'password', with: user.password

    click_button 'Login'

    visit

    click_on 'View Cart'

    click_on 'Checkout'

    expect(current_path).to eq(orders_path)
    expect(page).to have_content("Order was successfully placed")
    expect(page).to have_content(Order.first.created_at)
  end
end
