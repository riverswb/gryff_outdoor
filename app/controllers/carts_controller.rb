class CartsController < ApplicationController

  def index

  end

  def create
    item = Item.find(params[:item_id])

    @backpack
  end


end