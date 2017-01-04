require 'rails_helper'

RSpec.feature "When a user adds items to their cart", type: :feature do
  before(:all) do
    create_list(:item, 10)
  end

  scenario "a message is displayed" do
    item = Item.first

    visit item_path(item)
    click_button "Add Item"

    expect(page).to have_content "You now have 1 #{item.title}."
  end
end