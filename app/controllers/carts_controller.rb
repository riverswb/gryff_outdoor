class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def show
    @items = Item.item_list(@cart.contents)
    @checkout_path = path?(session[:user])
    @total_cost = @cart.total_cost
  end

  def path?(user)
    if user
      return view_context.link_to "Checkout", orders_path, method: "post" 
    else
      return view_context.link_to "Login or Create Account to Checkout", login_path
    end
  end

  def create
    item = Item.find(params[:item_id])
    @cart.add_item(item.id)
    session[:cart] = @cart.contents
    flash[:notice] = "You now have #{pluralize(@cart.count_of(item.id), item.title)}."
    redirect_back fallback_location: items_path
  end

  def destroy
    @item = Item.find(params[:item_id])
    @cart.remove(@item.id)
    flash[:success] = "Successfully removed #{view_context.link_to(@item.title, item_path(@item))} from your cart."
    redirect_to cart_path(@cart)
  end

  def update
    item = Item.find(params[:item_id])
    @cart.change_quantity(item.id, params[:quantity_change])
    redirect_to cart_path(@cart)
  end
end
