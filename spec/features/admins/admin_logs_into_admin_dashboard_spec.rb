require 'rails_helper'

RSpec.feature "When an admin logs in" do
  scenario "they are redirected to the admin dashboard" do
    user = create(:user, role: 1)
    visit login_path

    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password

    within ".form_inline" do
      click_on "Login"
    end

    expect(current_path).to eq admin_dashboard_path
  end
end