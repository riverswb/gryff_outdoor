require 'rails_helper'

RSpec.feature 'Admin sees orders on dashboard' do
  before :each do
    @admin = create(:user, role: 1)
    @user1 = create(:user)
    @user2 = create(:user)
    @user3 = create(:user)
    @ordered = create(:order)
    @paid = create(:order, status: 1)
    @cancelled = create(:order, status: 2)
    @completed = create(:order, status: 3)
    visit login_path
    fill_in "Email", with: @admin.email
    fill_in "Password", with: @admin.password
    click_button "Login"
  end

  scenario 'can see total number of orders for each status type' do
    visit admin_dashboard_path

    expect(page).to have_content("(1) total paid orders.")
    expect(page).to have_content("(1) total completed orders.")
    expect(page).to have_content("(1) total cancelled orders.")
  end

  scenario 'can see link for each order' do
    visit admin_dashboard_path

    expect(page).to have_content(/#{@ordered.status} order from #{@ordered.updated_at} #{@ordered.count} items See Details/i)
    expect(page).to have_content(/#{@paid.status} order from #{@paid.updated_at} #{@paid.count} items See Details/i)
    expect(page).to have_content(/#{@completed.status} order from #{@completed.updated_at} #{@completed.count} items See Details/i)
    expect(page).to have_content(/#{@cancelled.status} order from #{@cancelled.updated_at} #{@cancelled.count} items See Details/i)
    expect(page).to have_link("See Details")
  end

  scenario 'can filter orders by status' do
    visit admin_dashboard_path

    expect(page).to have_select('status')
  end

  scenario 'can view only ordered orders' do
    visit admin_dashboard_path
    select('ordered', :from => 'status')
    click_button("Sort")

    expect(page).to have_content(/#{@ordered.status} order from #{@ordered.updated_at} #{@ordered.count} items See Details/i)
  end

  scenario 'can view only paid orders' do
    visit admin_dashboard_path
    select('paid', :from => 'status')
    click_button("Sort")

    expect(page).to have_content(/#{@paid.status} order from #{@paid.updated_at} #{@paid.count} items See Details/i)
  end

  scenario 'can view only completed orders' do
    visit admin_dashboard_path
    select('completed', :from => 'status')
    click_button("Sort")

    expect(page).to have_content(/#{@completed.status} order from #{@completed.updated_at} #{@completed.count} items See Details/i)
  end

  scenario 'can view only cancelled orders' do
    visit admin_dashboard_path
    select('cancelled', :from => 'status')
    click_button("Sort")

    expect(page).to have_content(/#{@cancelled.status} order from #{@cancelled.updated_at} #{@cancelled.count} items See Details/i)
  end
# And I have links to transition between statuses
#  - I can click on "cancel" on individual orders which are "paid" or "ordered"
#  - I can click on "mark as paid" on orders that are "ordered"
#  - I can click on "mark as completed" on orders that are "paid"

  scenario 'can change status of each order' do
    visit login_path
    fill_in "Email", with: @admin.email
    fill_in "Password", with: @admin.password
    click_button "Login"
    
  end
end