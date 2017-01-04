require 'rails_helper'

RSpec.feature "When a users visits cart path" do

  attr_reader :items

  before(:each) do
    @items = create_list(:item, 10)
  end

  scenario "they can see all items in their cart" do
    visit item_path(items[0])
    click_on "Add Item"
    click_on "Add Item"
    visit item_path(items[1])
    click_on "Add Item"
    visit item_path(items[2])
    click_on "Add Item"

    click_on "View Cart"

    expect(page).to have_content items[0].title
    expect(page).to have_content items[2].title
  end
end