require 'rails_helper'

RSpec.feature "When a visitor visits login page" do
  scenario "they can create an account" do
    visit login_path

    click_on "Create Account"

    fill_in "user[first_name]", :with => "David"
    fill_in "user[last_name]", :with => "Knott"
    fill_in "user[email]", :with => "david@gmail.com"
    fill_in "user[password]", :with => "1234"
    fill_in "user[password_confirmation]", :with => "1234"

    click_on "Create Account"

    expect(page).to have_content "Logged in as David Knott"
    expect(page).to have_content "david@gmail.com"
    expect(page).to have_link "Logout"
  end
end