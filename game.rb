require_relative 'board.rb'
require_relative 'minetile.rb'
require 'byebug'

class Game

  def initialize(bombs=10,size=9)
    @board = Board.new(bombs,size)
    @size = size
  end

  def play
    # debugger
    puts %x{clear}
    board.render
    pos = Game.get_user_input("Which position? ex: 0,5", get_valid_positions)
    action = Game.get_user_input("Reveal(r) or Flag(f)", ["r", "f"])
  end

  private
  attr_reader :board, :size

  def self.parse_ans(answer)
    answer.split(",").map{|char| Integer(char) - 1}
  end

  def self.get_user_input(prompt, valid_answers)
    answer = ""
    begin
      puts prompt
      answer = gets.chomp.strip
      answer = Game.parse_ans(answer) unless answer.length == 1
      raise unless valid_answers.include?(answer)
    rescue
      retry
    end
    answer
  end

  def get_valid_positions
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

if __FILE__ == $PROGRAM_NAME
  puts "Let's play Minesweeper!"
  ans = Game.get_user_input("Easy(e) or Hard(h)?", ["e", "h"])
  case ans
  when "e"
    game = Game.new(10,9)
  when "h"
    game = Game.new(40,16)
  end
  game.play
end
