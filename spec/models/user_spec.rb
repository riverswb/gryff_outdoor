require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:first_name)}
    it { is_expected.to validate_presence_of(:last_name)}
    it { is_expected.to validate_presence_of(:email)}
    it { is_expected.to validate_presence_of(:password)}
    it { is_expected.to validate_presence_of(:password_confirmation)}
    it { is_expected.to validate_uniqueness_of(:email)}
  end

  describe "relationships" do
    it { should have_many(:orders)}
  end

  describe "admin functionality" do
    it "user can be created as an admin" do
      user = create(:user, role: 1)

      expect(user.role).to eq("admin")
      expect(user.admin?).to be_truthy
    end

    it "user can be created as a default user" do
      user = create(:user)

      expect(user.role).to eq("default")
      expect(user.default?).to be_truthy
    end
  end
end