require 'rails_helper'

RSpec.feature "Visitor can view categories", type: :feature do
  before :each do
    @first_category = Category.create(name: "Fishing")
    @second_category = Category.create(name: "NotFishing")
    @item1 = create(:item, category: @first_category)
    @item2 = create(:item, category: @first_category) 
  end  
  scenario "visitor goes to categories index" do
    visit "/#{@first_category.name}"
    
    expect(page).to have_content(@item1.title)
    expect(page).to have_content(@item2.title)
    expect(page).to have_content(@first_category.name)

    expect(page).to_not have_content(@second_category.name)
  end
end