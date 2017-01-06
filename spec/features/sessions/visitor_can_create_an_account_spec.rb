require 'rails_helper'

RSpec.feature "When a user visits root path" do
  scenario "they can see login page" do
    visit "/"

    expect(page).to have_link "Login"
    
    click_on "Login"

    expect(current_path).to eq "/login"

    fill_in "user[:username]", :with => "David"
    fill_in "user[:password]", :with => "123"

    expect(page).to have_link "Create Account"
  end
end