class Item < ApplicationRecord
  validates :title,:description, :price, :image, presence: :true

  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items


  enum status: [:active, :retired]

end
