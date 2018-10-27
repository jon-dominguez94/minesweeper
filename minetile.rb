class MineTile

  def initialize(value)
    @value = value
  end

  def inspect
    "#{self.value}"
  end
  private
  attr_reader :value

end
