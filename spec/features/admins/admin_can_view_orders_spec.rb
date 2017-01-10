
# issueEighteen:
# title: Admin Orders
# body: >
# As an Admin
# When I visit the dashboard
# Then I can see a listing of all orders
# And I can see the total number of orders for each status **("Ordered", "Paid", "Cancelled", "Completed")**
# And I can see a link for each individual order
# And I can filter orders to display by each status type  **("Ordered", "Paid", "Cancelled", "Completed")**
# And I have links to transition between statuses
#  - I can click on "cancel" on individual orders which are "paid" or "ordered"
#  - I can click on "mark as paid" on orders that are "ordered"
#  - I can click on "mark as completed" on orders that are "paid"
require 'rails_helper'

RSpec.feature 'Admin sees orders on dashboard' do
  before :all do
    @admin = create(:user, role: 1)
    @user1 = create(:user)
    @user2 = create(:user)
    @user3 = create(:user)
    @completed_order = create(:order)
    # @paid_order = create(:order, status: 1)
    # @ordered = create(:order, status: 2)
  end

  scenario 'can see total number of orders for each status type' do
    visit login_path
    fill_in "Email", with: @admin.email
    fill_in "Password", with: @admin.password
    click_button "Login"

    expect(page).to have_content "#{@completed_order.status.capitalize} Order from #{@completed_order.updated_at}"
  end

  scenario 'can see link for each order' do
    visit login_path
    fill_in "Email", with: @admin.email
    fill_in "Password", with: @admin.password
    click_button "Login"

    expect(page).to have_link "See Details"
  end

  scenario 'can filter orders by status' do
    visit login_path
    fill_in "Email", with: @admin.email
    fill_in "Password", with: @admin.password
    click_button "Login"

    within('Status') do
      page.should have_link 'Completed'
      page.should have_link 'Paid'
      page.should have_link 'Ordered'
    end
  end

  scenario 'can change status of each order' do
    visit login_path
    fill_in "Email", with: @admin.email
    fill_in "Password", with: @admin.password
    click_button "Login"
    
  end
end