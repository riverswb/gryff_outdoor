class ChargesController < ApplicationController
  def new
  end

  def create
    @amount = 500

    customer = Strip::Customer.create(
      :email => params[:stripeEmail],
      :source => params[:stripeToken]
    )

    chart = Strip::Charge.create(
      :customer     => customer.id,
      :amount       => @amount,
      :description  => "Rails Stripe customer",
      :currency     => "usd"
    )

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end

end
