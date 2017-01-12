require 'rails_helper'

RSpec.feature "When a visitor visits root path" do

  attr_reader :user

  before(:each) do
    @user = create(:user)
  end

  scenario "they can login" do
    visit "/"

    click_on "Log in"

    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password

    expect(page).to have_link "Create Account"

    within ".form_inline" do
      click_on "Log in"
    end

    expect(current_path).to eq dashboard_path
  end

  scenario "they cannot login with a blank field" do
    visit login_path

    fill_in "Email", :with => user.email
    fill_in "Password", :with => "wrong_password"

    within ".form_inline" do
      click_on "Log in"
    end

    expect(current_path).to eq login_path
    expect(page).to have_content "Invalid email/password combination"
  end

  scenario "they cannot login with an incorrect password" do
    visit login_path

    fill_in "Password", :with => user.password

    within ".form_inline" do
      click_on "Log in"
    end

    expect(current_path).to eq login_path
    expect(page).to have_content "Invalid email/password combination"
  end

end