require 'rails_helper'

RSpec.feature "When a user visits their user dashboard" do

  before(:all) do
    @user = create(:user)
    @address = @user.create(:address)
  end

  