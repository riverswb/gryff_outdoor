require 'rails_helper'

RSpec.feature "When a use visits item path" do
  scenario "they can see attributes of a single item" do
    item = create(:item)
    visit item_path(item)

    expect(page).to have_content item.title
    expect(page).to have_content item.description
  end
end