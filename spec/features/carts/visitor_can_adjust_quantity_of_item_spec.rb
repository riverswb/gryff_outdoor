require 'rails_helper'

RSpec.feature 'Visitor can adjust the quantity of an item in the cart', type: :feature do

    # attr_reader :cart
    #
    before(:each) do
    #   item = create(:item)
      @cart = Cart.new(nil)
    #   @cart.add_item(item.id)
    #   session[:cart] = @cart.contents
    end

    scenario 'as a visitor with an item in cart' do
      item = create(:item)

      visit item_path(item)
      click_on "Add Item"

      click_on "View Cart"

      expect(page).to have_content(item.title)
      expect(page).to have_content("1")
      expect(page).to have_content(item.price)

      click_on "+"

      # expect(current_path).to eq(cart_path(@cart))
      expect(page).to have_content("Total Cost: #{item.price * 2}")
    end
end
