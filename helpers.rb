module Helpers
  def generate_code(length, range)
    code = ''
    length.times do
      code += rand(1..range).to_s
    end
    code.split('')
  end

  # used for the set filter that computer uses
  def guess_compare(guess, code = @code)
    correct = 0
    correct_different_index = 0
    item_taken = []
    correct_guess = []
    guess.split('').each_with_index do |item, idx|
      if item == code[idx]
        correct += 1
        item_taken << idx
        correct_guess[idx] = item
      else
        correct_guess[idx] = 'X'
        code.each_with_index do |code_value, code_index|
          if item == code_value && guess[code_index] != code_value && !item_taken.include?(code_index)
            correct_different_index += 1
            item_taken << code_index
            break
          end
        end
      end
    end
    "C:#{correct} and CD:#{correct_different_index}"
    [correct, correct_different_index]
  end

  # used for the string output for both computer and player feedback
  def guess_compare_computer(guess, code = @code)
    correct = 0
    correct_different_index = 0
    item_taken = []
    correct_guess = []
    guess.split('').each_with_index do |item, idx|
      if item == code[idx]
        correct += 1
        item_taken << idx
        correct_guess[idx] = item
      else
        correct_guess[idx] = 'X'
        code.each_with_index do |code_value, code_index|
          if item == code_value && guess[code_index] != code_value && !item_taken.include?(code_index)
            correct_different_index += 1
            item_taken << code_index
            break
          end
        end
      end
    end
    "C:#{correct} and CD:#{correct_different_index}"
  end

  # makes sure player input is using correct digits
  def guess_input(code,range,turns)
    puts "Enter guess, length: #{code.length} range: 1-#{range}, turns: #{turns}"
    guess = ''
    loop do
      guess = gets.chomp
      if guess.length == code.length && guess.scan(/\D/).empty?
        break
      else
        puts 'Please enter a valid input'
        next
      end
    end
    guess
  end

  # takes code from player using gets
  def create_code
    code = ''
    loop do
      code = gets.chomp.split('')
      if code.length == length && code.join('').scan(/\D/).empty?
        if code.include?('7') || code.include?('8') || code.include?('9') || code.include?('0')
          puts 'Please enter numbers between 1-6'
          next
        else
          break
        end
      else
        puts 'Please enter a valid input'
        next
      end
    end
    code
  end

  def player_feedback(guess)
    if guess.split('') == code
      puts 'YOU WIN!'
      true
    elsif guess != code
      p guess_compare_computer(guess)
      false
    else
      false
    end
  end

  def computer_feedback(guess, attempts)
    if guess.split('') == code
      puts "COMPUTER WINS! in #{attempts} turns"
      true
    elsif guess != code
      guess_compare_computer(guess)
      false
    else
      false
    end
  end

  def start_guessing
    turns.times do
      self.guess = guess_input(code, range, turns)
      break if player_feedback(guess)

      self.turns -= 1
    end
    if turns == 0
      puts 'YOU LOSE!'
    end
  end

  def player_role(role)
    case role
    when '1'
      puts "create a code between 1-6"
      @code = create_code
      puts "computer starts guessing"
      computer_guess
      # will need to change start_computer so computer can guess
    when '2'
      start_guessing
    end
  end

  def create_set
    set = Array(1111..6666)
    set.filter! { |item| !item.to_s.include?('0') }
    set.filter! { |item| !item.to_s.include?('7') }
    set.filter! { |item| !item.to_s.include?('8') }
    set.filter! { |item| !item.to_s.include?('9') }
    set
  end
end
