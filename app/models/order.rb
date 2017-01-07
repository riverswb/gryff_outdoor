class Order < ApplicationRecord
belongs_to :user
has_many :order_items
has_many :items, through: :order_items

  def count
    self.items.count
  end

  def total_price
    self.items.inject(0) do |sum, item|
      sum += item.price
      sum
    end
  end
end