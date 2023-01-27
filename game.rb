require_relative 'helpers'

class Game
  include Helpers

  attr_reader :length, :range, :code, :guess
  attr_accessor :turns

  def initialize(turns, length = 4, range = 6)
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

  def start_guessing
    p code
    turns.times do
      @guess = guess_input(code, range, turns)
      break if player_feedback(@guess)

      self.turns -= 1
    end
    if turns == 0
      puts "YOU LOSE!"
    end
  end

  def player_feedback(guess)
    if guess.split('') == @code
      puts "YOU WIN!"
      true
    elsif guess != @code
      guess_compare(guess)
      false
    else
      false
    end
  end

  def computer_guess_result(guess)
    correct = 0
    correct_different_index = 0
    item_taken = []
    correct_guess = []
    #puts "guess: #{guess}"
    #puts "code:  #{code}"
    guess.each_with_index do |item, idx|
      if item == code[idx]
        correct += 1
        item_taken << idx
        correct_guess[idx] = item
        # puts "correct #{item} #{idx}"
      else
        correct_guess[idx] = 'X'
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
    #puts "C:#{correct} and CD:#{correct_different_index}"
    result_of_guess = [correct, correct_different_index]
    correct_guess
  end

  def computer_guess
    set = create_set
    guess = set.delete(1111).to_s.split('')
    filter_clue = computer_guess_result(guess)
    if filter_clue == code
      puts "Solved: #{guess}"
      return guess
    end


    index_to_check = []
    filter_clue.each_with_index do |item, idx|
      if item != 'X'
        index_to_check << idx
      end
    end
    index_to_check


    set.each_with_index do |item, idx|
      
    end

    p filter_clue
    p set.length
    p set.include?(1122)
    p set.length


  end

end

new_game = Game.new(12)
new_game.start_guessing
