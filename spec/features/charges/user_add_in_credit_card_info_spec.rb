require 'rails_helper'
require 'stripe_mock'

describe "When a user visits new charge path" do
  let(:stripe_helper) { StripeMock.create_test_helper }
  before { StripeMock.start }
  after { StripeMock.stop }

  it "creates a stripe customer" do

    customer = Stripe::Customer.create({
      email: 'johnny@appleseed.com',
      card: stripe_helper.generate_card_token
    })
    expect(customer.email).to eq('johnny@appleseed.com')
  end

  it "creates a stripe plan" do
    plan = stripe_helper.create_plan(:id => 'my_plan', :amount => 1500)


    expect(plan.id).to eq('my_plan')
    expect(plan.amount).to eq(1500)
  end
end