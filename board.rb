require 'byebug'

class Board

  def initialize(bombs=10, size=9)
    @grid = Array.new(size){Array.new(size)}
    @all_pos = get_all_board_pos
    populate(bombs)
    @revealed_pos = []
  end

  def flag(pos)
      self[pos].flag
  end

  def unflag(pos)
    self[pos].unflag
  end

  def reveal(pos)
    # debugger
    queue = [pos]
    until queue.empty?
      current_pos = queue.shift
      self[current_pos].reveal
      revealed_pos << current_pos
      neighbors = get_valid_neighbors(current_pos)
      unless neighbors.any? {|n_pos| bomb_pos.include?(n_pos)}
        (queue += neighbors - revealed_pos).uniq!
      end
    end
  end

  def lost?
    # if revealed_pos.any? {|pos| self[pos].value == :*}
    unless (revealed_pos & bomb_pos).empty?
      bomb_pos.each {|pos| self[pos].reveal}
      return true
    end
    false
  end

  def won?
    (revealed_pos | bomb_pos).sort == all_pos.sort
  end

  def display
    render
  end


  private

  attr_reader :grid, :revealed_pos, :all_pos, :bomb_pos

  def render
    row_output = "    |"
    (1..grid.length).each do |i|
      row_output += i < 10 ? " #{i}  |" : " #{i} |"
    end
    puts row_output
    puts "-----"*(grid.length+1)
    grid.each_with_index do |row, i|
      row_output = i < 9 ? " #{i+1}  |" : " #{i+1} |"
      row.each do |tile|
        if tile.flagged
          output = "?".light_red
          row_output += " #{output}  |"
        elsif tile.hidden
          row_output += "    |"
        else
          output =  ""
          case tile.value
          when 0
            output = "-".light_yellow
          when :*
            output = tile.value.to_s.light_red
          when 1
            output = "1".light_cyan
          when 2
            output = "2".light_magenta
          else
            output = tile.value.to_s.light_blue
          end
          row_output += " #{output}  |"
        end
      end
      puts row_output
      puts "-----"*(grid.length+1)
    end
    nil
  end

  def [](pos)
    row,col = pos
    grid[row][col]
  end

  def []=(pos, value)
    row,col = pos
    grid[row][col] = MineTile.new(value)
  end

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
      count += 1 if self[pos].value == :*
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
    @bomb_pos = all_pos.shuffle.shuffle.shuffle[0...amount]
    bomb_pos.each do |pos|
      self[pos] = :*
    end
     all_pos - bomb_pos
  end

  def get_all_board_pos
    size = grid.length
    positions = []
    (0...size).each do |i|
      (0...size).each do |j|
        pos = [i,j]
        positions << pos
      end
    end
    positions
  end

  def inspect
    "\#<#{self.class}:#{self.object_id}>"
  end
end
