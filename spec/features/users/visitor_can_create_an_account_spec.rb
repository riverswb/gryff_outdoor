require 'rails_helper'

RSpec.feature "When a visitor visits login page" do
  scenario "they can create an account" do
    visit login_path

    click_on "Create Account"

    fill_in "First name", :with => "David"
    fill_in "Last name", :with => "Knott"
    fill_in "Email", :with => "david@gmail.com"
    fill_in "Password", :with => "1234"
    fill_in "Password confirmation", :with => "1234"

    click_on "Create Account"

    expect(page).to have_content "Logged in as David Knott"
    expect(page).to have_content "david@gmail.com"
    expect(page).to have_link "Logout"
  end
end