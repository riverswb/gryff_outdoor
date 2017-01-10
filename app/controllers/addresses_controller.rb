class AddressesController < ApplicationController
  before_action :set_user

  def new
    @address = @user.addresses.new
  end

  def create
    @address = @user.addresses.new(address_params)
    if @address.save
      flash[:success] = "You successfully added an address to your account."
      redirect_to dashboard_path
    else
      flash[:danger] = "Error! Make sure you filled in all the fields correctly."
      redirect_to new_user_address_path(@user)
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    flash[:deleted] = "That address is GONE. Forever." 
    redirect_to dashboard_path
  end

private

  def address_params
    params.require(:address).permit(:street_address, :secondary_address, :city, :state_abbr, :zip_code)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

end
