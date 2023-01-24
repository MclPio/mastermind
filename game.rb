require_relative 'support_functions'
# returns a code (length, range)

class Game
  include SupportFunctions

  attr_reader :turns, :length, :range, :code, :guess

  def initialize(turns, length, range)
    @turns = turns
    @length = length
    @range = range
    @code = generate_code(length, range)
    @guess = ''
  end

  def start_option
    puts 'Would you like to (1) create the secret code or (2) guess'
    answer = ''
    loop do
      answer = gets.chomp
      break if answer == '1' || answer == '2'

      puts "INVALID INPUT"
    end
    player_role(answer)
  end

  def player_role(role)
    case
    when role == '1'
      @code = gets.chomp
      start
    when role == '2'
      start
    end
  end

  def start
    turns.times do
      @guess = player_guess(code, range, turns)
      break if player_feedback(@guess)

      @turns -= 1
    end
    if @turns == 0
      puts "YOU LOSE!"
    end
  end

  def player_feedback(guess)
    if guess == @code
      puts "YOU WIN!"
      true
    elsif guess != @code
      guess_compare(guess, @code)
    else
      false
    end
  end
end

new_game = Game.new(4, 4, 6)
new_game.start_option
