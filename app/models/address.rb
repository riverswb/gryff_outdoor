class Address < ApplicationRecord
  validates :street_address, :city, :state_abbr, :zip_code, :user_id, presence: :true

  belongs_to :user
  has_many :orders
end