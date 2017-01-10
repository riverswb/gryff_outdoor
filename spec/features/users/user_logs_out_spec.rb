require 'rails_helper'

RSpec.feature 'A logged in user logs out' do
  attr_reader :user
  before(:each) do
    @user = create(:user)
    visit login_path

    fill_in 'email', with: @user.email
    fill_in 'password', with: @user.password
    click_button 'Login'
  end

  describe 'a logged in user logs out' do
    scenario 'from the dashboard' do
      expect(current_path).to eq(dashboard_path)

      click_on 'Logout'

      expect(current_path).to eq(login_path)
    end

    scenario 'from the index' do
    visit items_path

    click_on 'Logout'

    expect(current_path).to eq(items_path)
    end

    scenario 'from the cart' do
      visit cart_path

      click_on 'Logout'

      expect(current_path).to eq(cart_path)
    end

    scenario 'from a category' do
      category = create(:category)
      visit "/#{category.name}"

      click_on 'Logout'

      expect(current_path).to eq("/#{category.name}")
    end
  end
end
