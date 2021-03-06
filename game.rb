require_relative 'board.rb'
require_relative 'minetile.rb'
require 'colorize'
require 'byebug'

class Game

  def initialize(bombs=10,size=9)
    @board = Board.new(bombs,size)
    @size = size
  end

  def play
    until game_over? do
      puts %x{clear}
      board.display
      pos = Game.get_user_input("Which position? ex: 1,5", get_valid_positions)
      action = Game.get_user_input("Reveal(r), Flag(f), or Unflag(u)", ["r", "f", "u"])
      make_move(pos, action)
    end
    puts %x{clear}
    puts board.lost? ? "You lose!" : "You Win!"
    board.display
  end

  private
  attr_reader :board, :size

  def game_over?
    board.lost? || board.won?
  end

  def make_move(pos, action)
    case action
    when "f"
      board.flag(pos)
    when "u"
      board.unflag(pos)
    when "r"
      board.reveal(pos)
    end
  end

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
      puts "Invalid response"
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
