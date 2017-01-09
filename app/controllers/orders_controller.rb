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
    @order = @user.orders.create(status: "ordered")
    items = session[:cart]
    items.each do |item_id, quantity|
      @order.add_item(item_id, quantity)
    end
    flash[:success] = "Order was successfully placed"
    redirect_to orders_path
  end

  

end
