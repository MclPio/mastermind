module SupportFunctions
  def generate_code(length, range)
    code = ''
    length.times do
      code += rand(1..range).to_s
    end
    puts code
    code
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
    puts "Guessed #{correct_spot} correct and #{other_spot} in another location"
    false
  end

  def player_guess(code,range,turns)
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
end
