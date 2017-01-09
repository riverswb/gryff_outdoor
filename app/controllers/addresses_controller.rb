class AddressesController < ApplicationController
  before_action :set_user

  def new
    @address = @user.addresses.new
  end

  def create
  end

  def destroy
  end

private

  def set_user
    @user = User.find(params[:user_id])
  end

end
