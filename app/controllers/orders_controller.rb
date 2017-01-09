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
    @user = User.find(session[:user])
    @order = @user.orders.create(status: "Ordered")
    items = session[:cart]
    items.each do |item_id, quantity|
      item = Item.find(item_id.to_i)
      add_item(@order, item, quantity)
    end
    flash[:success] = "Order was successfully placed"
    redirect_to orders_path
  end

  def add_item(order, item, quantity)
    quantity.times do
      order.items << item
    end
  end

end
