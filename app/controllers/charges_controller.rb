class ChargesController < ApplicationController
  
  def new
    if session[:user]
      @address = Address.new
      @amount = @cart.total_cost
      @amount_string =  to_pennies(@amount)
      @user = User.find(session[:user])
      @addresses = @user.addresses.map{|address|address.street_address}
    else
      redirect_to login_path
    end
  end
end
