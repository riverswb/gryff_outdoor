require 'rails_helper'

RSpec.feature 'Admin can edit items' do
  before(:each) do
    @item = create(:item)
    @admin = create(:user, role: 1)

    visit login_path

    fill_in 'email', with: @admin.email
    fill_in 'password', with: @admin.password
    click_button 'Login'
    visit admin_items_path

    click_on 'Actions'
  end

  scenario 'an admin can edit an item from admin items path' do

    expect(current_path).to eq(edit_admin_item_path(@item))

    fill_in 'item[title]', with: 'TeSt'
    fill_in 'item[description]', with: 'Test description'
    fill_in 'item[price]', with: @item.price + 1

    click_on 'Update'

    expect(current_path).to eq(item_path(@item))
    expect(page).to have_content('TeSt')
    expect(page).to_not have_content(@item.title)
    expect(page).to have_content('Test description')
    expect(page).to_not have_content(@item.description)
    expect(page).to have_content("$#{@item.price + 1}")
  end

  describe 'sad path' do
    scenario 'deletes title' do

      fill_in 'item[title]', with: nil
      fill_in 'item[description]', with: 'Test description'
      fill_in 'item[price]', with: @item.price + 1

      click_on 'Update'

      expect(current_path).to eq(edit_admin_item_path(@item))
      expect(page).to have_content("Title can't be blank")
    end

    scenario 'deletes description' do

      fill_in 'item[title]', with: 'Test'
      fill_in 'item[description]', with: nil
      fill_in 'item[price]', with: @item.price.round(2) + 1

      click_on 'Update'

      expect(current_path).to eq(edit_admin_item_path(@item))
      expect(page).to have_content("Description can't be blank")
    end

    scenario 'deletes price' do
      fill_in 'item[title]', with: 'Test'
      fill_in 'item[description]', with: 'Test Description'
      fill_in 'item[price]', with: nil

      click_on 'Update'

      expect(current_path).to eq(edit_admin_item_path(@item))
      expect(page).to have_content("Price can't be blank")
    end

    scenario 'deletes image' do
      fill_in 'item[title]', with: 'Test'
      fill_in 'item[description]', with: 'Test Description'
      fill_in 'item[price]', with: @item.price.round(2)
      fill_in 'item[image]', with: nil

      click_on 'Update'

      expect(current_path).to eq(edit_admin_item_path(@item))
      expect(page).to have_content("Image can't be blank")
    end
  end
end
