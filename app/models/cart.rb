class Cart

  attr_reader :contents

  def initialize(initial_contents)
    @contents = intial_contents || {}
  end


end