class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @canceled_or_completed_message = @order.canceled_or_completed
  end

  def index
    @user = User.find(session[:user])
    @orders = @user.orders
  end

end