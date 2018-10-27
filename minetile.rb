class MineTile

  attr_reader :value, :hidden, :flagged

  def initialize(value)
    @value = value
    @hidden = false
    @flagged = false
  end

  def flag
    @flagged = true
  end

  def unflag
    @flagged = false
  end

  def reveal
    @hidden = false unless flagged
    value
  end

  def inspect
    "#{self.value}"
  end

  private

end
