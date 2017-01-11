require 'rails_helper'

RSpec.describe Address, type: :model do
  describe "validations" do
    it {is_expected.to validate_presence_of(:street_address)}
    it {is_expected.to validate_presence_of(:city)}
    it {is_expected.to validate_presence_of(:state_abbr)}
    it {is_expected.to validate_presence_of(:zip_code)}
  end

  describe "relationships" do
    it {should belong_to(:user)}
    it {should have_many(:orders)}
  end
end