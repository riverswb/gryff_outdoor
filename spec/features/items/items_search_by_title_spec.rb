require 'rails_helper'

RSpec.feature 'items can be searched by strings included in item title' do
  before(:each) do
    a1 = create(:item, title: "a1")
    a2 = create(:item, title: "a2")
    b1 = create(:item, title: "b1")
    b2 = create(:item, title: "b2")

    visit items_path
  end

  scenario 'sorts items by title a' do
    fill_in "q[title_cont]", with: "a"

    expect(page).to have_content("a1")
    expect(page).to have_content("b1")

    click_on "Item Search"

    expect(page).to have_content("a1")
    expect(page).to have_content("a2")
    expect(page).to_not have_content("b1")
    expect(page).to_not have_content("b2")
  end

  scenario 'sorts items by title b' do
    fill_in "q[title_cont]", with: "b"

    expect(page).to have_content("a1")
    expect(page).to have_content("b1")

    click_on "Item Search"

    expect(page).to have_content("b1")
    expect(page).to have_content("b2")
    expect(page).to_not have_content("a1")
    expect(page).to_not have_content("a2")
  end

end
