require 'rails_helper'

RSpec.feature "When a users visits cart path" do

  attr_reader :items,
              :cart

  before(:each) do
    @items = create_list(:item, 10)
    @cart = Cart.new(nil)
  end

  scenario "they can see all items in their cart" do
    visit item_path(items[0])
    click_on "Add Item"
    click_on "Add Item"
     visit item_path(items[1])
    click_on "Add Item"
     visit item_path(items[2])
    click_on "Add Item"
    total_cost = items[0].price * 2  + items[1].price + items[2].price

    click_on "View Cart"

    expect(page).to have_content items[0].title
    expect(page).to have_content items[2].title
    expect(page).to have_content total_cost
  end
end