require 'rails_helper'

RSpec.feature "When a users visits orders path" do

  attr_reader :items

  before(:all) do
    @items = create_list(:item, 10)
  end
  scenario "they see all orders belonging to them" do
    user = create(:user_with_orders)
    visit login_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_on "Login"

    visit orders_path

    expect(page).to have_content "Shipped"
    expect(page).to_no have_content "Proccessing"
    expect(page).to have_content "1 item"
    expect(page).to have_content "2 items"
    expect(page).to have_content total_price
  end
end