class Admin::OrdersController < Admin::BaseController


  def dashboard
    @orders = Order.sort(params[:status])
    @status_list = Order.status_list
  end

  def update
    order = Order.find(params[:id])
    order.update(status: params[:update_status])
    redirect_to admin_dashboard_path
  end

end