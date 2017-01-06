require 'rails_helper'

RSpec.feature "When a vistor visits cart page" do
  before(:all) do
    create_list(:item, 10)
  end

  scenario "they need to login or create an account" do
    item = Item.first
    visit item_path(item)
    click_button "Add Item"
    click_button "Add Item"
    click_on "View Cart"

    expect(page).to_not have_button "Checkout"
    expect(page).to have_link "Login or Create Account to Checkout"
    
    click_on "Login or Create Account to Checkout"

    expect(current_path).to eq login_path
  end
end