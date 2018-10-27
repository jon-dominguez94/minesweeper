class MineTile

  attr_reader :value, :hidden

  def initialize(value)
    @value = value
    @hidden = true
  end

  def reveal
    @hidden = false
  end

  def inspect
    "#{self.value}"
  end

  private

end
