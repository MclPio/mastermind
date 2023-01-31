require_relative 'helpers'

class Game
  include Helpers

  attr_reader :length, :range
  attr_accessor :turns, :guess, :code

  def initialize(turns, length = 4, range = 6)
    @turns = turns
    @length = length
    @range = range
    @code = generate_code(length, range)
    @guess = ''
  end

  def start
    puts 'Would you like to (1) create the secret code or (2) guess'
    answer = ''
    loop do
      answer = gets.chomp
      break if answer == '1' || answer == '2'

      puts "INVALID INPUT"
    end
    player_role(answer)
  end

  def computer_guess
    set = create_set
    initial_guess = '1122'
    p "Computer guesses #{initial_guess}"
    p guess_compare_computer(initial_guess)
    attempts = 1
    loop do
      guess_feedback = guess_compare(initial_guess)
      filter_same_feedback = set.filter do |item|
        guess_compare(item.to_s, initial_guess.split('')) == guess_feedback
      end
      g_hash = Hash.new(0)
      filter_same_feedback.each do |g|
        score_hash = Hash.new(0)
        filter_same_feedback.each do |c|
          score_hash[guess_compare(g.to_s, c.to_s.split(''))] += 1
        end
        max_values = score_hash.max_by{|k,v| v}
        g_hash[g] = (max_values[0])
      end
      set = filter_same_feedback
      initial_guess = (g_hash.min_by{|k,v| v})[0].to_s
      p "Computer guesses #{initial_guess}"
      p guess_compare_computer(initial_guess)
      attempts += 1
      break if computer_feedback(initial_guess, attempts)
    end
  end
end

new_game = Game.new(12)
new_game.start