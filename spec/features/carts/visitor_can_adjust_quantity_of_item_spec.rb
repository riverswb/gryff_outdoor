require 'rails_helper'

RSpec.feature 'Visitor can adjust the quantity of an item in the cart', type: :feature do

  scenario 'as a visitor with an item in cart' do
    item = create(:item)

    visit item_path(item)
    click_on 'Add Item'
    click_on 'View Cart'

    expect(page).to have_content(item.title)
    expect(page).to have_content('1')
    expect(page).to have_content(item.price)

    click_on '+'

    expect(page).to have_content("Total Cost: $#{item.price * 2}")

    click_on '-'

    expect(page).to have_content("Total Cost: $#{item.price}")
  end
end
