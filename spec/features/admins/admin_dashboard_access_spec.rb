require 'rails_helper'

RSpec.feature "When an admin visits dashboard page" do
  context "as admin" do
    it "allows admin to see admin dashboard" do
      user = create(:user, role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit admin_dashboard_path

      expect(page).to have_content "Admin Dashboard"
    end

    it "default user does not see admin dashboard" do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit admin_dashboard_path

      expect(page).to_not have_content "Admin Dashboard"
      expect(page).to have_content "The page you were looking for doesn't exist"
    end

    it "visitor does not see admin dashboard" do
      visit admin_dashboard_path

      expect(page).to_not have_content "Admin Dashboard"
      expect(page).to have_content "The page you were looking for doesn't exist"
    end
  end
end