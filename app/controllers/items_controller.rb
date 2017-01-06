class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def show
    if Item.exists?(params[:id])
      @item = Item.find(params[:id])
    else
      not_found
    end
  end

  private 
  def not_found
    render :file => 'public/404.html', :status => :not_found, :layout => false
  end
end
