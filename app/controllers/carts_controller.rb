class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper
  
  def show
    @items = @cart.contents.map do |item, quantity|
      [Item.find(item), quantity]
    end
    @total_cost = @cart.total_cost
  end

  def create
    item = Item.find(params[:item_id])

    @cart.add_item(item.id)
    session[:cart] = @cart.contents

    flash[:notice] = "You now have #{pluralize(@cart.count_of(item.id), item.title)}."
    redirect_to item_path(item)
  end

  def destroy
    item = Item.find(params[:item_id])
    binding.pry
    @cart.remove(params[item.id])
    flash[:notice] = "Successfully removed #{item.title} from your cart."
    redirect_to cart_path(@cart)
  end


end