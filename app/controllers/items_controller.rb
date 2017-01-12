class ItemsController < ApplicationController

  def index
  end

  def show
    if Item.exists?(params[:id])
      @item = Item.find(params[:id])
    else
      not_found
    end
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    if item.save
      flash[:success] = "Item successfully updated"
      redirect_to item_path(item)
    else
      flash[:danger] = item.errors.full_messages.first
      redirect_to edit_admin_item_path(item)
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :image, :status)
  end

  def not_found
    render :file => 'public/404.html', :status => :not_found, :layout => false
  end
end
