class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :order_items
  has_many :items, through: :order_items

  enum status: %w(ordered paid cancelled completed)

  scope :ordered, -> {where(:status => 0)}
  scope :paid, -> {where(:status => 1)}
  scope :cancelled, -> {where(:status => 2)}
  scope :completed, -> {where(:status => 3)}

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

  def self.sort(category)
    if category == 'paid'
      @orders = Order.paid
    elsif category == 'cancelled'
      @orders = Order.cancelled
    elsif category == 'completed'
      @orders = Order.completed
    elsif category == 'ordered'
      @orders = Order.ordered
    else
      @orders = Order.all
    end
  end

  def self.status_list
    group(:status).count(:status)
  end

  def update_status(status)
    if status == ""
    else
      update(status: status)
      save
    end
  end
end