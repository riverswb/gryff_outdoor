require 'rails_helper'

RSpec.feature "When a use visits order show page" do

  attr_reader :items

  before(:all) do
    @items = create_list(:item, 10)
  end
  
  scenario "they can see each item in that order with subtotals" do
    user = create(:user_with_orders)
    order  = user.orders.first
    items = order.items
    create(:order_item, item: items.first, order: order)
    total_price = order.total_price
    visit login_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    within ".form_inline" do
      click_on "Login"
    end

    visit orders_path

    click_on "See Details", {match: :first}

    expect(page).to have_link items[0].title
    expect(page).to have_content "Quantity: #{order.order_items.last.quantity}"
    expect(page).to have_content "Your Order from #{order.created_at}"
    expect(page).to have_content order.status
    expect(page).to have_content total_price
    expect(page).to have_content "Completed at"
  end
end