require_relative 'minetile'
require 'byebug'

class Board

  attr_reader :grid

  def initialize(bombs=10, grid=Array.new(9){Array.new(9)})
    # debugger
    @grid = grid
    populate(bombs)
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

  attr_reader :grid
  def populate(bombs)
    empty_tiles = place_random_bombs(bombs)
    empty_tiles.each do |pos|
      # look at all valid neighbors, add bombs, set self to bomb number
      neighbors = get_valid_neighbors(pos)
    end
  end

  def get_valid_neighbors(pos)
    neighbors = []
    row, col = pos
    (-1..1).each do |i|
      (-1..1).each do |j|
        neighbors << [row+i, col+j]
      end
    end
    neighbors.select {|r,c| r.between?(0,grid.length-1) &&
                            c.between?(0,grid.length-1)}
  end

  def place_random_bombs(amount)
    empty_tiles = get_board_pos_with_val(nil)
    random_positions = empty_tiles.shuffle[0...amount]
    random_positions.each do |pos|
      self[pos] = 0
    end
    empty_tiles - random_positions
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
