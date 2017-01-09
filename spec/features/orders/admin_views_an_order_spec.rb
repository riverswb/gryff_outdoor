require 'rails_helper'

RSpec.feature "When an admin visits an order page" do

  before(:all) do
    @order = create(:order)
  end

  scenario "they can see the order's date and time" do
    visit order_path(@order)
    expect(page).to have_content(@order.created_at)
  end

  scenario "they can see the purchaser's name and address" do
    visit order_path(@order)
    expect(page).to have_content(@order.user.first_name)
    expect(page).to have_content(@order.user.last_name)
  end

  scenario "they see all items as links with quantities, prices, and line subtotals" do
  end

  scenario "they can see the order total and status" do
  end

end

