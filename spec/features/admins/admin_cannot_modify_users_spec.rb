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
    save_and_open_page
    click_on "Edit"

    fill_in "email", with: "test@test.com"
    click_on "Update"

    expect(page).to have_content("Email: test@test.com")

    visit user_path(user)

    expect(page).to_not have_link("Edit")
  end
end
