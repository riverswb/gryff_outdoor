class Cart
  attr_reader :contents, :address

  def initialize(initial_contents, address="Please enter an address")
    @contents = initial_contents ||= {}
    @address  = address
  end

  def add_item(item_id)
    contents[item_id.to_s] ||= 0
    contents[item_id.to_s] += 1
  end

  def remove(item_id)
    contents[item_id.to_s] -= 1
    contents.delete_if {|k, v| v == 0 }
  end

  def change_quantity(item_id, quantity_change)
    return add_item(item_id) if quantity_change == "increase"
    remove(item_id)
  end

  def count_of(item_id)
    contents[item_id.to_s]
  end

  def total_items
    contents.inject(0) do |sum, item_id|
      sum += 1 * item_id[1]
      sum
    end
  end
  
  def total_cost
    contents.inject(0) do |sum, item_id|
      item = Item.find(item_id[0])
      sum += item.price * item_id[1]
      sum
    end
  end

end