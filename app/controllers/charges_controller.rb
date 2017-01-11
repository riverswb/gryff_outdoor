class ChargesController < ApplicationController
  
  def new
    @address = Address.new
    @amount = @cart.total_cost
    @amount_string =  to_pennies(@amount)
    @user = User.find(session[:user])
    @addresses = @user.addresses.map{|address|address.street_address}
  end

end
