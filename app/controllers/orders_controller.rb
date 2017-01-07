class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
  end

  def index
    @user = User.find(session[:user])
    @orders = @user.orders
  end

end