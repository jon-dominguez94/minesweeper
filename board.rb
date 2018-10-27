require_relative 'minetile'
require 'byebug'

class Board

  # attr_reader :grid

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
    self[pos].reveal
    render
  end

  def render
    row_output = "   |"
    (1..grid.length).each do |i|
      row_output << " #{i} |"
    end
    puts row_output
    puts "----"*(grid.length+1)
    grid.each_with_index do |row, i|
      row_output = " #{i+1} |"
      row.each do |tile|
        row_output += tile.hidden ? "   |" : " #{tile.value} |"
      end
      puts row_output
      puts "----"*(grid.length+1)
    end
    nil
  end

  private

  attr_reader :grid
  def populate(bombs)
    empty_tiles = place_random_bombs(bombs)
    empty_tiles.each do |pos|
      neighbors = get_valid_neighbors(pos)
      bomb_count = get_bomb_count(neighbors)
      self[pos] = bomb_count
    end
  end

  def get_bomb_count(neighbors)
    count = 0
    neighbors.each do |pos|
      next if self[pos] == nil
      count += 1 if self[pos].value == 0
    end
    count
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
                            c.between?(0,grid.length-1) &&
                            [r,c] != pos}
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
