require 'rails_helper'

RSpec.feature 'Admin sees orders on dashboard' do
  before :each do
    @admin = create(:user, role: 1)
    @user1 = create(:user)
    @user2 = create(:user)
    @user3 = create(:user)
    @ordered = create(:order)
    visit login_path
    fill_in "Email", with: @admin.email
    fill_in "Password", with: @admin.password
    click_button "Login"
  end

  scenario 'can see total number of orders for each status type' do
    @paid = create(:order, status: 1)
    @cancelled = create(:order, status: 2)
    @completed = create(:order, status: 3)
    visit admin_dashboard_path
    
    expect(page).to have_content("(1) total paid orders.")
    expect(page).to have_content("(1) total completed orders.")
    expect(page).to have_content("(1) total cancelled orders.")
  end

  scenario 'can see link for each order' do
    @paid = create(:order, status: 1)
    @cancelled = create(:order, status: 2)
    @completed = create(:order, status: 3)
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
    @paid = create(:order, status: 1)
    visit admin_dashboard_path

    select('paid', :from => 'status')
    click_button("Sort")

    expect(page).to have_content(/#{@paid.status} order from #{@paid.updated_at} #{@paid.count} items See Details/i)
  end

  scenario 'can view only completed orders' do
    @completed = create(:order, status: 3)
    visit admin_dashboard_path

    select('completed', :from => 'status')
    click_button("Sort")

    expect(page).to have_content(/#{@completed.status} order from #{@completed.updated_at} #{@completed.count} items See Details/i)
  end

  scenario 'can view only cancelled orders' do
    @cancelled = create(:order, status: 2)
    visit admin_dashboard_path

    select('cancelled', :from => 'status')
    click_button("Sort")

    expect(page).to have_content(/#{@cancelled.status} order from #{@cancelled.updated_at} #{@cancelled.count} items See Details/i)
  end


  scenario 'can change status to cancelled' do
    visit admin_dashboard_path
    select('cancelled', :from => 'update_status', match: :first)
    click_button("Update", match: :first)

    expect(page).to have_content(/Cancelled order from #{@ordered.updated_at} 5 items See Details/i)
  end

  scenario 'can change status to paid' do
    visit admin_dashboard_path
    select('paid', :from => 'update_status', match: :first)
    click_button("Update", match: :first)

    expect(page).to have_content(/Paid order from #{@ordered.updated_at} 5 items See Details/i)
  end

  scenario 'can change status to completed' do
    visit admin_dashboard_path
    select('completed', :from => 'update_status', match: :first)
    click_button("Update", match: :first)

    expect(page).to have_content(/Completed order from #{@ordered.updated_at} 5 items See Details/i)
  end

  scenario 'can change status to ordered' do
    visit admin_dashboard_path
    select('ordered', :from => 'update_status', match: :first)
    click_button("Update", match: :first)

    expect(page).to have_content(/Ordered order from #{@ordered.updated_at} 5 items See Details/i)
  end
end