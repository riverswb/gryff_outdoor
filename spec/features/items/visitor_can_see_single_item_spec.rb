require 'rails_helper'

RSpec.feature "When a use visits item path" do
  scenario "they can see attributes of a single item" do
    item = create(:item)
    visit item_path(item)

    expect(page).to have_content item.title
    expect(page).to have_content item.description
  end

  scenario 'will get 404 if item does not exist' do
    visit '/items/500'

    expect(page).to have_content("The page you were looking for doesn't exist")
  end
end