require_relative 'minetile'

class Board

  attr_reader :grid

  def initialize(bombs=10, grid=Array.new(9){Array.new(9)})
    @grid = grid
    place_random_bombs(bombs)
  end

  def [](pos)
    row,col = pos
    grid[row][col]
  end

  def []=(pos, value)
    row,col = pos
    grid[row][col] = MineTile.new(value)
  end

  def reveal(pos)

  end

  def render

  end

  private

  # attr_reader :grid

  def place_random_bombs(amount)
    empty_tiles = get_board_pos_with_val(nil)
    random_positions = empty_tiles.shuffle[0...amount]
    leftovers = empty_tiles - random_positions
    random_positions.each do |pos|
      self[pos] = 0
    end
    nil
  end

  def get_board_pos_with_val(value=nil)
    size = grid.length
    matching_positions = []
    (0...size).each do |i|
      (0...size).each do |j|
        pos = [i,j]
        matching_positions << pos if self[pos] == value
      end
    end
    matching_positions
  end

  def inspect
    "\#<#{self.class}:#{self.object_id}>"
  end
end
