class Admin::OrdersController < Admin::BaseController


  def dashboard
    @orders = Order.all
    # where(status: order_params[:order][:status])
    # byebug
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end
end