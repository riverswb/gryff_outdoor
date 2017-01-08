require 'rails_helper'

RSpec.feature 'When an admin views items index' do
  scenario 'admin clicks on view items from admin dashboard' do
    items_active = create_list(:item, 10)
    inactive_item = create(:item, status: 1)
    items = items_active << inactive_item

    user = create(:user, role: 1)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Login'

    expect(current_path).to eq(admin_dashboard_path)

    click_on 'View Items'

    expect(current_path).to eq(admin_items_path)

    expect(page).to have_link(items_active.first.title)
    expect(page).to have_link(items_active.last.title)
    expect(page).to have_link(inactive_item.title)

    expect(page).to have_content(items_active.first.description)
    expect(page).to have_content(items_active.last.description)
    expect(page).to have_content(inactive_item.description)

    expect(page).to have_content(items_active.first.status)
    expect(page).to have_content(items_active.last.status)
    expect(page).to have_content(inactive_item.status)

    expect(page).to have_link('Actions')
  end
end
