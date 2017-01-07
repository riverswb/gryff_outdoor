class OrdersController < ApplicationController

  def index
    @user = User.find(session[:user])
    @orders = @user.orders
  end

end