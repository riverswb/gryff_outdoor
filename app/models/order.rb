class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  enum status: %w(ordered paid cancelled completed)



# scope :completed, -> {where(:status => 0)}
# scope :ordered, -> {where(:status => 1)}
# scope :paid, -> {where(:status => 2)}

  def count
    self.items.count
  end

  def total_price
    self.items.inject(0) do |sum, item|
      sum += item.price
      sum
    end
  end

  def canceled_or_completed
    if self.status == "completed"
      return "Completed at #{self.updated_at}"
    elsif self.status == "cancelled"
      return "Cancelled at #{self.updated_at}"
    end
  end

  def self.make_order(order, items)
    items.each do |item_id, quantity|
      order.add_item(item_id, quantity)
    end
  end

  def add_item(item_id, quantity)
    item = Item.find(item_id.to_i)
    quantity.times do
      self.items << item
    end
  end
end