require 'rails_helper'

RSpec.feature "When a user visits their user dashboard" do

  before(:all) do
    @user = create(:user_with_addresses)
  end

  scenario "they can go to a new page to create an address" do
    visit login_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => @user.password
      within ".form_inline" do
        click_on "Log in"
      end
    click_on "Add an Address"
    expect(current_path).to eq(new_user_address_path(@user))

    @address = @user.addresses.first
    fill_in "Street Address", :with => @address.street_address
    fill_in "Secondary Address", :with => @address.secondary_address
    fill_in "City", :with => @address.city
    fill_in "State (Abbreviation)", :with => @address.state_abbr
    fill_in "Zip Code", :with => @address.zip_code
    click_on "Add Address"

    expect(current_path).to eq(dashboard_path)
    expect(@user.addresses.first).to eq(@address)
  end
  
  scenario "they're redirected to addresses#new if it doesn't save" do
    visit login_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => @user.password
      within ".form_inline" do
        click_on "Log in"
      end
    click_on "Add an Address"
    @address = @user.addresses.first
    fill_in "Street Address", :with => @address.street_address
    fill_in "Secondary Address", :with => @address.secondary_address
    fill_in "City", :with => @address.city
    fill_in "State (Abbreviation)", :with => @address.state_abbr
    click_on "Add Address"

    expect(current_path).to eq(new_user_address_path(@user))
  end
end