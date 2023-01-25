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
    case role
    when '1'
      @code = gets.chomp
      puts "computer starts guessing"
      # will need to change start_computer so computer can guess
    when '2'
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

  def computer_guess_result(guess)
    correct = 0
    correct_different_index = 0
    item_taken = []
    puts "guess: #{guess}"
    puts "code:  #{code}"
    guess.each_with_index do |item, idx|
      if item == code[idx]
        correct += 1
        item_taken << idx
        # puts "correct #{item} #{idx}"
      else
        code.each_with_index do |code_value, code_index|
          if item == code_value && guess[code_index] != code_value && !item_taken.include?(code_index)
            correct_different_index += 1
            # puts "correct_different_index #{idx} #{code_index}"
            item_taken << code_index
            break
          end
        end
      end
    end
    puts "C:#{correct} and CD:#{correct_different_index}"
    result_of_guess = [correct, correct_different_index]
  end

  def computer_guess()
    set = Array(1111..6666)
    guess = set.delete(1122).to_s.split('')
    computer_guess_result(guess)

    #set.filter { |item| }
  end
end

new_game = Game.new(4, 4, 6)
new_game.computer_guess
