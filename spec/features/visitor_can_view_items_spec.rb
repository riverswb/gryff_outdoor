require 'rails_helper'

RSpec.feature "Visitor can view all items", type: :feature do
  scenario "visitor goes to items index" do
    create_list(:item, 6)

    visit items_path

    expect(page).to have_content(Item.first.title)
    expect(page).to have_content(Item.last.title)
  end
end
