require_relative 'board.rb'
require_relative 'minetile.rb'

class Game

  def initialize(bombs=10,size=9)
    @board = Board.new(bombs,size)
    @size = size
  end

  def play
    puts %x{clear}
    board.render
    get_user_input("Which position do you want to reveal?", get_valid_poisitions)
  end

  # private
  attr_reader :board, :size

  def get_valid_poisitions
    valid_positions = []
    (0...size).each do |i|
      (0...size).each do |j|
        pos = [i,j]
        valid_positions << pos
      end
    end
    valid_positions
  end
end

def get_user_input(prompt, valid_answers)
  answer = ""
  begin
    puts prompt
    answer = gets.chomp.strip
    raise unless valid_answers.include?(answer)
  rescue
    retry
  end
  answer
end

if __FILE__ == $PROGRAM_NAME
  puts "Let's play Minesweeper!"
  ans = get_user_input("Easy(e) or Hard(h)?", ["e", "h"])
  case ans
  when "e"
    game = Game.new(10,9)
  when "h"
    game = Game.new(40,16)
  end
  game.play
end
