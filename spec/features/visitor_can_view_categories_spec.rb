require 'rails_helper'

RSpec.feature "Visitor can view categories", type: :feature do
  before :each do
    @first_category = Category.create(name: "Fishing & Supply")
    @second_category = Category.create(name: "Fishing")
    @item1 = create(:item, category: @first_category)
    @item2 = create(:item, category: @first_category)

    @item3 = create(:item, category: @second_category)
    @item4 = create(:item, category: @second_category)
  end

  scenario 'visitor goes to /:category_name' do
    visit "/#{@second_category.name}"

    expect(page).to have_content(@item3.title)
    expect(page).to have_content(@item4.title)
    expect(page).to have_content(@second_category.name)

    expect(page).to_not have_content(@first_category.name)
  end

  scenario "visitor goes to categories index" do
    visit "/#{@first_category.name.gsub(' ', '%20')}"
    #gsub added to simulate server url action
    
    expect(page).to have_content(@item1.title)
    expect(page).to have_content(@item2.title)
    expect(page).to have_content(@first_category.name)

    expect(page).to_not have_content(@item3.title)
  end

  scenario 'unknown category name returns 404' do
    visit '/NotFishing'

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end