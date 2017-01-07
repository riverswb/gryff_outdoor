class OrdersController < ApplicationController

  def index
    @user = User.find(session[:user])
    @orders = User.orders
  end

end