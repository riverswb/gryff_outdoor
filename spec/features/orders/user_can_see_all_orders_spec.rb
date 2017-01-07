require 'rails_helper'

RSpec.feature "When a users visits orders path" do

  attr_reader :items

  before(:all) do
    @items = create_list(:item, 10)
  end

  scenario "they see all orders belonging to them" do
    user = create(:user_with_orders)
    orders = user.orders
    total_price = orders.first.total_price
    visit login_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    within ".form_inline" do
      click_on "Login"
    end

    visit orders_path

    expect(page).to have_content "1 item"
    expect(page).to have_content "Order from #{orders.first.created_at}"
  end
end