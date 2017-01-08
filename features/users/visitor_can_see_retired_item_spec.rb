require 'rails_helper'

RSpec.feature 'Visitor can see different item details;', type: :feature do
  before :each do
    @active_item = create(:item)
    @retired_item = create(:item, status: 1)
  end

  scenario "sees 'add item' button when item is active" do
    visit item_path(@active_item)

    expect(page).to have_button("Add Item")
  end

  scenario "sees 'Item Retired' if item is retired" do
    visit item_path(@retired_item)

    expect(page).to have_content("Item Retired")
  end
end