class ChargesController < ApplicationController
  def new
    @amount = @cart.total_cost
    @amount_string =  to_pennies(@amount)
  end

  def to_pennies(amount)
    (amount * 100).to_i.to_s
  end

def create
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

  rescue Stripe::CardError => e
    flash[:danger] = e.message
    redirect_to new_charge_path
  end
end
