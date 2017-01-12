require 'rails_helper'

RSpec.feature 'Admins cannot edit users data' do

  before (:each) do
    @user = create(:user)
    @admin = create(:user, role: 1)
  end
  scenario 'as a logged in admin can edit own profile' do
    visit login_path

    fill_in 'email', with: @admin.email
    fill_in 'password', with: @admin.password
    click_button 'Log in'

    visit user_path(@admin)
    click_on 'Edit'

    fill_in 'user[first_name]', with: 'Testy'
    fill_in 'user[last_name]', with: 'McTesterson'
    fill_in 'user[email]', with: 'test@test.com'
    fill_in 'user[password]', with: @admin.password
    fill_in 'user[password_confirmation]', with: @admin.password

    click_on 'Update'

    expect(page).to have_content('Name: Testy McTesterson')
    expect(page).to have_content('Email: test@test.com')
  end

  scenario "As a logged in admin, cannot edit a user's profile" do
    visit login_path

    fill_in 'email', with: @admin.email
    fill_in 'password', with: @admin.password
    click_button 'Log in'

    visit admin_user_path(@user)

    expect(page).to have_content(@user.first_name)
    expect(page).to have_content(@user.last_name)
    expect(page).to have_content(@user.email)
    expect(page).to_not have_link('Edit')
  end

  describe 'SAD Path for edidting admin profile' do
    scenario 'deletes first name' do
      visit login_path

      fill_in 'email', with: @admin.email
      fill_in 'password', with: @admin.password
      click_button 'Log in'

      visit user_path(@admin)
      click_on 'Edit'

      fill_in 'user[first_name]', with: nil
      fill_in 'user[last_name]', with: 'McTesterson'
      fill_in 'user[email]', with: 'test@test.com'
      fill_in 'user[password]', with: @admin.password
      fill_in 'user[password_confirmation]', with: @admin.password

      click_on 'Update'

      expect(current_path).to eq(edit_user_path(@admin))
      expect(page).to have_content("First name can't be blank")
    end

    scenario 'deletes last name' do
      visit login_path

      fill_in 'email', with: @admin.email
      fill_in 'password', with: @admin.password
      click_button 'Log in'

      visit user_path(@admin)
      click_on 'Edit'

      fill_in 'user[first_name]', with: 'Testy'
      fill_in 'user[last_name]', with: nil
      fill_in 'user[email]', with: 'test@test.com'
      fill_in 'user[password]', with: @admin.password
      fill_in 'user[password_confirmation]', with: @admin.password

      click_on 'Update'

      expect(current_path).to eq(edit_user_path(@admin))
      expect(page).to have_content("Last name can't be blank")
    end

    scenario 'deletes email' do
      visit login_path

      fill_in 'email', with: @admin.email
      fill_in 'password', with: @admin.password
      click_button 'Log in'

      visit user_path(@admin)
      click_on 'Edit'

      fill_in 'user[first_name]', with: 'Testy'
      fill_in 'user[last_name]', with: 'McTesterson'
      fill_in 'user[email]', with: nil
      fill_in 'user[password]', with: @admin.password
      fill_in 'user[password_confirmation]', with: @admin.password

      click_on 'Update'

      expect(current_path).to eq(edit_user_path(@admin))
      expect(page).to have_content("Email can't be blank")
    end

    scenario 'Password left blank' do
      visit login_path

      fill_in 'email', with: @admin.email
      fill_in 'password', with: @admin.password
      click_button 'Log in'

      visit user_path(@admin)
      click_on 'Edit'

      fill_in 'user[first_name]', with: 'Testy'
      fill_in 'user[last_name]', with: 'McTesterson'
      fill_in 'user[email]', with: 'test@test.com'
      fill_in 'user[password]', with: nil
      fill_in 'user[password_confirmation]', with: @admin.password

      click_on 'Update'

      expect(current_path).to eq(edit_user_path(@admin))
      expect(page).to have_content('Incorrect password')
    end

    scenario "Password confirmation left blank / doesn't match password" do
      visit login_path

      fill_in 'email', with: @admin.email
      fill_in 'password', with: @admin.password
      click_button 'Log in'

      visit user_path(@admin)
      click_on 'Edit'

      fill_in 'user[first_name]', with: 'Testy'
      fill_in 'user[last_name]', with: 'McTesterson'
      fill_in 'user[email]', with: 'test@test.com'
      fill_in 'user[password]', with: @admin.password
      fill_in 'user[password_confirmation]', with: nil

      click_on 'Update'

      expect(current_path).to eq(edit_user_path(@admin))
      expect(page).to have_content("Password confirmation doesn't match
                                    Password")
    end

    scenario 'Password and confirmation do not match' do
      visit login_path

      fill_in 'email', with: @admin.email
      fill_in 'password', with: @admin.password
      click_button 'Log in'

      visit user_path(@admin)
      click_on 'Edit'

      fill_in 'user[first_name]', with: 'Testy'
      fill_in 'user[last_name]', with: 'McTesterson'
      fill_in 'user[email]', with: 'test@test.com'
      fill_in 'user[password]', with: @admin.password
      fill_in 'user[password_confirmation]', with: 'wrong'

      click_on 'Update'

      expect(current_path).to eq(edit_user_path(@admin))
      expect(page).to have_content("Password confirmation doesn't match
                                    Password")
    end

  end
end
