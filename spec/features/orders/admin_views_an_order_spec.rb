require 'rails_helper'

RSpec.feature "When an admin visits an order page" do

  before(:all) do
    @user       = create(:user_with_orders_and_addresses)
    @order      = @user.orders.first
    @items      = @order.items
    @address    = @order.address
    @item       = @items.first
    @quantity   = Item.find_quantity(@item, @order)
    @line_total = Item.find_line_subtotal(@quantity, @item)
  end

  scenario "they can see the order's date and time" do
    visit order_path(@order)
    
    expect(page).to have_content(@order.created_at)
  end

  scenario "they can see the purchaser's name and address" do
    visit order_path(@order)
    
    expect(page).to have_content(@order.user.first_name)
    expect(page).to have_content(@order.user.last_name)
    expect(page).to have_content(@address.street_address)
    expect(page).to have_content(@address.secondary_address)
    expect(page).to have_content(@address.city)
    expect(page).to have_content(@address.state_abbr)
    expect(page).to have_content(@address.zip_code)
  end

  scenario "they see all items as links with quantities, prices, and line subtotals" do
    visit order_path(@order)
    
    expect(page).to have_content(@item.price)
    expect(page).to have_content(@quantity)
    expect(page).to have_content(@line_total)
    
    click_on @item.title
    expect(current_path).to eq(item_path(@item))
  end

  scenario "they can see the order total and status" do
    visit order_path(@order)
    
    expect(page).to have_content(@order.status)
    expect(page).to have_content("")
  end

end

