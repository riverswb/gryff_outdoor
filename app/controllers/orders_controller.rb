class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @address = @order.address
    @canceled_or_completed_message = @order.canceled_or_completed
    @user = @order.user
  end

  def index
    @user = User.find(session[:user])
    @orders = @user.orders
  end

  def setup_charge
    # Amount in cents
    @amount = @cart.total_cost
    @amount_string = to_pennies(@amount)

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount_string,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )
  end

  def create
    setup_charge
    @user = User.find(session[:user])
    @order = @user.orders.create(status: 0)
    address = Address.find_by(street_address: params[:address])
    @order.address = address

    Order.make_order(@order, session[:cart])
    flash[:success] = "Order was successfully placed"
    redirect_to orders_path
  end

end
