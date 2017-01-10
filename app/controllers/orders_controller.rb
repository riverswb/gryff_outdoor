class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @address = @order.address
    @canceled_or_completed_message = @order.canceled_or_completed
    @quantity = @order.order_items.last.quantity
    @user = @order.user
  end

  def index
    @user = User.find(session[:user])
    @orders = @user.orders
  end

  def create
    @user = User.find(session[:user])
    @order = @user.orders.create(status: 0)
    Order.make_order(@order, session[:cart])
    flash[:success] = "Order was successfully placed"
    redirect_to orders_path
  end

end
