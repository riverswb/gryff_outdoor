require 'rails_helper'

RSpec.feature 'visitor can search for items from navbar' do
  before(:each) do
    a1 = create(:item, title: "a1")
    a2 = create(:item, title: "a2")
    b1 = create(:item, title: "b1")
    b2 = create(:item, title: "b2")
  end

  describe 'visitor can search items from:' do
    scenario 'landing page' do
      visit root_path

      within('ul') do
        fill_in 'q[title_cont]', with: "a"
        click_on 'Search'
      end

      expect(current_path).to eq(items_path)
      expect(page).to have_content("a1")
      expect(page).to have_content('a2')
      expect(page).to_not have_content('b1')
      expect(page).to_not have_content('b2')
    end
  end
end
