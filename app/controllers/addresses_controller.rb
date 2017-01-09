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
      flash[:alert] = "Error! Make sure you filled in all the fields correctly."
      render :new
    end
  end

  def destroy
  end

private

  def address_params
    params.require(:address).permit(:street_address, :secondary_address, :city, :state_abbr, :zip_code)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

end
