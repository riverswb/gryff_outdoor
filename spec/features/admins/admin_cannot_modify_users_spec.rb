require 'rails_helper'

RSpec.feature 'Admins cannot edit users data' do
  scenario 'as a logged in admin' do
    user = create(:user)
    admin = create(:user, role: 1)

    visit login_path

    fill_in "email", with: admin.email
    fill_in "password", with: admin.password
    click_button "Login"

    visit user_path(admin)
    click_on "Edit"

    fill_in "user[first_name]", with: "Testy"
    fill_in "user[last_name]", with: "McTesterson"
    fill_in "user[email]", with: "test@test.com"
    fill_in "user[password]", with: admin.password
    fill_in "user[password_confirmation]", with: admin.password

    click_on "Update"

    expect(page).to have_content("Name : Testy McTesterson")
    expect(page).to have_content("Email : test@test.com")

    visit user_path(user)

    expect(page).to_not have_link("Edit")
  end
end