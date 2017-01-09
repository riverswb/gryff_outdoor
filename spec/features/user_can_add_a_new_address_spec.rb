require 'rails_helper'

RSpec.feature "When a user visits their user dashboard" do

  before(:all) do
    @user = create(:user)
  end

  scenario "they can go to a new page to create an address" do
    visit login_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => @user.password
      within ".form_inline" do
        click_on "Login"
      end
    click_on "Add an Address"
    expect(current_path).to eq(new_user_address_path(@user))
  end

end