require 'rails_helper'

RSpec.feature "When an admin visits all orders page" do
  context "as admin" do
    it "allows admin to see all orders by all users" do
      user = create(:user, role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit admin_all_orders_path
      expect(page).to have_content "All Orders"
    end

    it "default user does not see admin all orders" do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit admin_all_orders_path
      expect(page).to_not have_content "All Orders"
      expect(page).to have_content "The page you were looking for doesn't exist"
    end
  end
end