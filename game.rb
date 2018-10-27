class Game

  def initialize(bombs=10,size=9)
    @board = Board.new(bombs,size)
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
end
