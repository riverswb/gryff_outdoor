require 'rails_helper'

RSpec.feature 'items can be searched by strings included in category name' do
  before(:each) do

    cat_1 = create(:category, name: "hiking")
    cat_2 = create(:category, name: "fishing")
    cat_3 = create(:category, name: "climbing")

    cat_1.items.create(title: "a1", description: "...", price: 0, image: "...")
    cat_1.items.create(title: "a2", description: "...", price: 0, image: "...")
    cat_2.items.create(title: "b1", description: "...", price: 0, image: "...")
    cat_2.items.create(title: "b2", description: "...", price: 0, image: "...")
    cat_3.items.create(title: "c1", description: "...", price: 0, image: "...")
    cat_3.items.create(title: "c2", description: "...", price: 0, image: "...")

    visit items_path
  end

    scenario 'sorts items by hiking category ' do
      expect(page).to have_content("a1")
      expect(page).to have_content("b1")
      expect(page).to have_content("c1")

      fill_in "q[category_name_cont]", with: "hiking"

      click_on "Category Search"

      expect(page).to have_content("a1")
      expect(page).to have_content("a2")
      expect(page).to_not have_content("b1")
      expect(page).to_not have_content("c2")
    end

    scenario 'sorts items by fishing category ' do
      expect(page).to have_content("a1")
      expect(page).to have_content("b1")
      expect(page).to have_content("c1")

      fill_in "q[category_name_cont]", with: "fishing"

      click_on "Category Search"

      expect(page).to have_content("b1")
      expect(page).to have_content("b2")
      expect(page).to_not have_content("a1")
      expect(page).to_not have_content("c2")
    end

    scenario 'sorts items by climbing category ' do
      expect(page).to have_content("a1")
      expect(page).to have_content("b2")
      expect(page).to have_content("c1")

      fill_in "q[category_name_cont]", with: "climbing"

      click_on "Category Search"

      expect(page).to have_content("c1")
      expect(page).to have_content("c2")
      expect(page).to_not have_content("a1")
      expect(page).to_not have_content("b2")
    end

    scenario 'sad path' do
      expect(page).to have_content("a1")
      expect(page).to have_content("b2")
      expect(page).to have_content("c1")

      fill_in "q[category_name_cont]", with: "x"

      click_on "Category Search"

      expect(page).to_not have_content("a1")
      expect(page).to_not have_content("b2")
      expect(page).to_not have_content("c1")
      expect(page).to_not have_content("x")
    end

end
