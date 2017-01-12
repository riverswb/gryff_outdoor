require 'rails_helper'

RSpec.feature "When a vistor visits cart page" do

  attr_reader :items

  before(:each) do
    @items = create_list(:item, 10)
    visit item_path(items[0])
    click_button "Add Item"
    click_button "Add Item"
  end

  scenario "they need to login or create an account" do
    click_on "View Cart"

    expect(page).to_not have_button "Checkout"
    expect(page).to have_link "Log in or Create Account to Checkout"
    
    click_on "Log in or Create Account to Checkout"

    expect(current_path).to eq login_path
  end

  scenario "they can create an account and their data is saved" do
    click_on "View Cart"
    click_on "Log in or Create Account to Checkout"
    click_on "Create Account"

    fill_in "user[first_name]", :with => "David"
    fill_in "user[last_name]", :with => "Knott"
    fill_in "user[email]", :with => "david@gmail.com"
    fill_in "user[password]", :with => "1234"
    fill_in "user[password_confirmation]", :with => "1234"

    click_on "Create Account"
    click_on "View Cart"

    expect(page).to have_content items[0].title
    expect(page).to have_content items[0].price
  end

  scenario "they can logout" do
    click_on "View Cart"
    click_on "Log in or Create Account to Checkout"
    click_on "Create Account"

    fill_in "user[first_name]", :with => "David"
    fill_in "user[last_name]", :with => "Knott"
    fill_in "user[email]", :with => "david@gmail.com"
    fill_in "user[password]", :with => "1234"
    fill_in "user[password_confirmation]", :with => "1234"

    click_on "Create Account"
    click_on "View Cart"

    click_on "Log out"
    
    expect(page).to have_link "Log in"
    expect(page).to_not have_link "Log out"
  end


end