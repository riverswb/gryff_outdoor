require 'rails_helper'

RSpec.feature "When an admin visits all orders page" do
  context "as admin" do
    it "allows admin to see all orders by all users" do
      user = User.create(email: "quidditchstar6969@gryffoutdoor.com",
                        password: "slytherinsuxx",
                        role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(:admin)
      visit admin_all_orders_path
      expect(page).to have_content "All Orders"
    end
  end
end