class Admin::ItemsController < Admin::BaseController

  def index
    @items = Item.all
  end

  def edit
    @item = Item.find(params[:id].to_i)
  end

end
