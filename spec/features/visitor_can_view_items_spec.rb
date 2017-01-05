require 'rails_helper'

RSpec.feature "Visitor can view all items", type: :feature do
  scenario "visitor goes to items index" do
    create_list(:item, 6)
    first_item = Item.first
    last_item = Item.last

    visit items_path

    expect(page).to have_content(first_item.title)
    expect(page).to have_content(last_item.title)
    expect(page).to have_content(first_item.description)
    expect(page).to have_content(last_item.description)
    expect(page).to have_content(first_item.price)
    expect(page).to have_content(last_item.price)
  end

  scenario "visitor adds item to cart from item index" do
    create_list(:item, 6)
    first_item = Item.first

    visit items_path

    click_on "Add to cart"

    expect(page).to have_content("#{first_item.title} has been added to the cart")

    visit cart_path

    expect(page).to have_content(first_item.title)
    expect(page).to have_content(first_item.price)
  end
end
