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
  descrive "admin functionality" do
    it "user can be created as an admin" do
      user = User.create(email: "quidditchstar6969@gryffoutdoor.com",
                        password: "slytherinsuxx",
                        role: 1)

      expect(user.role).to eq("admin")
      expect(user.admin?).to be_truthy
    end

    it "user can be created as a default user" do
      user = User.create(email: "draco@slytheroutdoor.com",
                        password: "pass"
                        role: 0)

      expect(user.role).to eq("default")
      expect(user.default?).to be_truthy
    end
end