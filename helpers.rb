module Helpers
  def generate_code(length, range)
    code = ''
    length.times do
      code += rand(1..range).to_s
    end
    code.split('')
  end

  def guess_compare(guess)
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
    puts "C:#{correct} and CD:#{correct_different_index}"
    [correct, correct_different_index]
  end


  def guess_input(code,range,turns)
    puts "Enter guess, length: #{code.length} range: 1-#{range}, turns: #{turns}"
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

  def create_set
    set = Array(1111..6666)
    set.filter! { |item| !item.to_s.include?('0') }
    set.filter! { |item| !item.to_s.include?('7') }
    set.filter! { |item| !item.to_s.include?('8') }
    set.filter! { |item| !item.to_s.include?('9') }
    set
  end
end
