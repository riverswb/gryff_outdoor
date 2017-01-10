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

    click_on 'Edit Item'

    expect(current_path).to eq(admin_edit_item_path)

    fill_in 'item[title]', with: "TeSt"

    click_on "Update"

    expect(current_path).to eq(item_path(@item))
  end
end
