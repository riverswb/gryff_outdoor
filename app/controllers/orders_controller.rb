class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @canceled_or_completed_message = @order.canceled_or_completed
    @quantity = @order.order_items.last.quantity
  end

  def index
    @user = User.find(session[:user])
    @orders = @user.orders
  end

  def create
    byebug
    @user = User.find(session[:user])
    items = session[:cart]
    items.each do |item, quantity|
      @user.orders.create(item: Item.find(item.to_i), quantity: quantity)
    end

    redirect_to orders_path
  end

end
