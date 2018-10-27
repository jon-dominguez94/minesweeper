class MineTile

  attr_reader :value

  def initialize(value)
    @value = value
  end

  def inspect
    "#{self.value}"
  end
  
  private

end
