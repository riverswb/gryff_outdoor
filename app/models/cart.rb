class Cart

  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents ||= {}
  end

  def add_item(item_id)
    contents[item_id.to_s] ||= 0
    contents[item_id.to_s] += 1
  end

  def count_of(item_id)
    contents[item_id.to_s]
  end

  def total_cost
    contents.inject(0) do |sum, item_id|
      item = Item.find(item_id[0])
      sum += item.price * item_id[1]
      sum
    end
  end



end