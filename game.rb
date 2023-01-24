require_relative 'generate_code'
# returns a code (length, range)

class Game
  include GenerateCode
  def initialize(turns)
    @turns = turns
    @code = generate_code(4,6)
    @guess = ''
  end

  def start
    @turns.times do
      @guess = player_guess
      break if player_feedback(@guess)
    end
  end

  def player_feedback(guess)
    if guess == @code
      puts "YOU WIN!"
      true
    elsif guess != @code

    else
      false
    end
  end

  def player_guess
    puts "Enter a guess for the code, length: #{@code.length} ranging from 1-9"
    guess = ''
    loop do
      guess = gets.chomp
      if guess.length == @code.length && guess.scan(/\D/).empty?
        break
      else
        puts 'Please enter a valid input'
        next
      end
    end
    guess
  end
end

new_game = Game.new(4)
new_game.start
