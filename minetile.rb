class MineTile

  def initialize(value="")
    @value = value
  end

  private
  attr_reader :value

  def inspect
    value
  end
end
