require 'rails_helper'

RSpec.feature 'Visitor is required to login to account before checkout', type: :feature do

  scenario "an existing user and a cart with items" do
    user = create(:user)
    item = create(:item)

    visit item_path(item)
    click_on "View Cart"
    click_on "Login or Register to Checkout"

    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_on 'Login'

    click_on 'View Cart'

    click_on 'Checkout'

    expect(current_path).to eq(orders_path)
    expect(page).to have_content("Oder was successfully placed")
    expect(page).to have_content(Order.first.title)
  end
end
