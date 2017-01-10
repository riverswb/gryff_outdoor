class Item < ApplicationRecord
  validates :title,:description, :price, :image, presence: :true

  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items


  enum status: [:active, :retired]

  def self.item_list(cart_items)
    cart_items.map do |item, quantity|
      [find(item), quantity]
    end
  end

  def self.find_quantity(item, order)
    order.items.where(id: item.id).count
  end

  def self.find_line_subtotal(quantity, item)
    item.price * quantity
  end
end
