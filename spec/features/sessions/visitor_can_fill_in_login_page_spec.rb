require 'rails_helper'

RSpec.feature "When a visitor visits root path" do

  attr_reader :user

  before(:each) do
    @user = create(:user)
  end

  scenario "they can login" do
    visit "/"

    click_on "Login"

    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password

    expect(page).to have_link "Create Account"

    within ".form_inline" do
      click_on "Login"
    end

    expect(current_path).to eq dashboard_path
  end

  scenario "they " do

  end

end