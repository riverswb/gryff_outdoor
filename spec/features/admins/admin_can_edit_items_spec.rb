require 'rails_helper'

RSpec.feature 'Admin can edit items' do
  before(:each) do
    @item = create(:item)
    @admin = create(:user, role: 1)

    visit login_path

    fill_in 'email', with: @admin.email
    fill_in 'password', with: @admin.password
    click_button 'Login'
  end

  scenario 'an admin can edit an item from admin items path' do
    visit admin_items_path

    click_on 'Actions'

    expect(current_path).to eq(edit_admin_item_path(@item))

    fill_in 'item[title]', with: "TeSt"

    click_on "Update"

    expect(current_path).to eq(item_path(@item))
    expect(page).to have_content("TeSt")
  end
end
