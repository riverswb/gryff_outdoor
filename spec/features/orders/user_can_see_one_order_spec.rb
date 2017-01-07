require 'rails_helper'

RSpec.feature "When a use visits order show page" do

  attr_reader :items

  before(:all) do
    @items = create_list(:item, 10)
  end
  
  scenario "they can see each item in that order with subtotals" do
    user = create(:user_with_orders)
    user.orders.first.items
    visit login_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    within ".form_inline" do
      click_on "Login"
    end

    visit orders_path
  end
end