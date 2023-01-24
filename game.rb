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

  def guess_compare(guess, code)
    i = 0
    correct_spot = 0
    other_spot = 0
    for char in code.split('')
      if char == guess[i]
        correct_spot += 1
      elsif guess.include?(char)
        other_spot += 1
      end
      i += 1
    end
    puts "You have guessed #{correct_spot} correct spots and #{other_spot} in another location"
    false
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

new_game = Game.new(12)
new_game.start
