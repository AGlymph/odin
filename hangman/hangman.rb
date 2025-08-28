require 'yaml'
require 'pry-byebug'

class Hangman_game 
  attr_reader :secret_word

  def initialize(dictionary_path, save_data_path = nil)

    if save_data_path.nil? then
      @dictionary_path = dictionary_path
      @last_word_starting_pos =  get_last_word_starting_pos
      @max_rounds = 7
      @current_round = 1
      @secret_word = get_random_word
      @secret_word_array = @secret_word.split('')
      @guesses = ''
      check_secret_word_with_guessed_letters
      puts "Starting New Game"
    else
      save_data = YAML.load File.read(save_data_path)
      @secret_word = save_data[:secret_word]
      @secret_word_array = @secret_word.split('')
      @guesses = save_data[:guesses]
      @current_round = save_data[:current_round]
      @max_rounds = save_data[:max_rounds]
      check_secret_word_with_guessed_letters
      puts "Save Game Loaded"
    end
    
    
    play
  end


  def get_last_word_starting_pos
    positions = [0,0]
    File.open(@dictionary_path, 'r') do |file|
      file.each_line do |line|
        positions << file.pos 
        positions.shift
      end
    end
    positions[0] 
  end

  def get_random_word(min_pos = 0, max_pos = @last_word_starting_pos)
    dictionary = File.open(@dictionary_path, 'r')
    dictionary.pos = rand(min_pos..max_pos)
    dictionary.gets == '\n' ? dictionary.pos += 1 : dictionary.pos
    # dictionary.rewind # used to get same word while testing
    dictionary.gets.chomp
  end

  def check_secret_word_with_guessed_letters
    @secret_word_gussed_only = @secret_word_array.map { |letter| @guesses.include?(letter) ? letter : '_'}
  end


  def get_input
    puts "Guess a letter a->z"
    input = gets.chomp.to_s.downcase
    if input == 'save' then
      return input
    end
    input = input.slice(0)
    @guesses = @guesses + input
    return input
  end

  def save_game 
    save_data = YAML.dump({
      :secret_word => @secret_word,
      :guesses => @guesses,
      :max_rounds => @max_rounds,
      :current_round => @current_round
    })

    f = File.open('save_data.yml', 'w')
    f.puts save_data
    f.close
  end

  def show_board
    puts "Secret Word: #{@secret_word_gussed_only.join(' ')}"
    puts "Your Guesses: #{@guesses}"
    
  end

  def play 
    for i in @current_round..@max_rounds
     
      puts "Round: #{i}"
      @current_round = i 
      show_board
      
      if get_input == 'save' then 
        puts "Game Saved and Ended"
        save_game
        break
      end
      
      check_secret_word_with_guessed_letters
     
      if !@secret_word_gussed_only.include?('_') 
        puts 'you win'
        break
      end
      puts "~~~~~~~~~~~~~"
    end

    "Sorry you lost :("
  end

end


puts "Hangman: New(n) or Continue(c)?"
save_data = nil
input = gets.chomp.to_s.downcase.slice(0)
if input == 'c' && File.exist?('save_data.yml') then 
  save_data = 'save_data.yml'
end

Hangman_game.new('dictionary.txt', save_data_path = save_data)