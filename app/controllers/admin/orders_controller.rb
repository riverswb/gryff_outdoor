class Admin::OrdersController < Admin::BaseController


  def dashboard
    @orders = Order.sort(params[:status])
    @status_list = Order.status_list
  end

  def edit
    byebug
  end

end