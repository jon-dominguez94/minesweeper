class MineTile

  attr_reader :value, :hidden, :flagged

  def initialize(value)
    @value = value
    @hidden = true
    @flagged = false
  end

  def flag
    @flagged = true if hidden
  end

  def unflag
    @flagged = false
  end

  def reveal
    @hidden = false unless flagged
    value
  end

  private
  
  def inspect
    "#{self.value}"
  end

end
