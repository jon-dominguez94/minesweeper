class Board


  attr_reader :grid
  def initialize(grid=Array.new(9){Array.new(9)})
    @grid = grid
  end

  def [](pos)
    row,col = pos
    grid[row][col]
  end

  def []=(pos, value)
    row,col = pos
    grid[row][col] = value
  end

  def reveal(pos)

  end

  def render
    place_random_bombs(10)
  end

  private

  def place_random_bombs(amount)
    empty_tiles = get_board_pos_with_val(nil)
    random_positions = empty_tiles.shuffle[0...amount]
    random_positions.each do |pos|
      self[pos] = '*'
    end
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

end
