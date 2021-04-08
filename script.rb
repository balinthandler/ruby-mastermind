require 'pry'
require 'colorize'
#binding.pry

# STORING AVAILABLE COLORS
# ADD YOU NAME
# BEGIN GAME
# ROLE CHOSING
# CODEMAKER SETS UP CODE
# CODEBREAKER GUESSES
# CHECK IF HITS
# CODEMAKER'S FEEDBACK
# CODEBREAKER GUESSES UNTIL HE WINS OR RUNS OUT OF GUESSING

module Colors
  #colors array for red, green, blue, yellow, magenta, orange
  @colors = ["r", "g", "b", "y", "m", "o"]

  def self.get_colors
    puts @colors
    return @colors
  end

  def self.pick_random
    picked = []
    4.times do
      random = rand(0..5)
      picked.push(@colors[random])
    end
    return picked
  end

end

module Intro
  def self.welcome
    puts "----------------------"
    puts "Welcome to Mastermind!"
    puts "----------------------"
  end
  
  def self.get_player
    loop do
      puts "Type your name!"
      @name = gets.chomp
      if @name.length > 0
        return @name
      end
    end
  end

  def self.get_role
    loop do
      puts "\nHello #{@name},"
      sleep 0.5
      puts "to play as CodeBreaker, type \"B\", or to play as CodeMaker, type \"M\", and press ENTER! "
      role = gets.chomp.upcase
      if role == "B" || role == "M"
        return role
      end
    end
  end

  def self.show_instructions
    puts "\n--Creating code--"
    sleep 0.5
    print "    "
    4.times do
      print " ?" 
      sleep 0.4 
    end
    puts "\n--Code created--"
    sleep 1
    puts "Try to guess the colors and their order in the four slots above! "
    puts "Available colors are: "     + " Red ".colorize(:background => :light_red) + " " +
      " Green ".colorize(:background => :light_green) + " " +
      " Blue ".colorize(:background => :blue) + " " +
      " Yellow ".colorize(:background => :light_yellow) + " " +
      " Magenta ".colorize(:background => :light_magenta) + " " +
      " Orange ".colorize(:background => :yellow)
    puts "One color could take multiple slots."
    puts "To guess, type only the initials, e.g. R for red, G for green etc.. "
    puts "Enter a pattern similar to this: RRBY. "
    puts "Which means your guess is Red Red Blue Yellow. "
    puts "The computer will give you feedback with 2 flags: "
    puts "White flag".colorize(:background => :light_white, :color => :black) + ": the color is correct, but it is on the wrong spot. "
    puts "Red flag".colorize(:background => :light_red, :color => :black) + ": the color is correct and it is on the right spot. "
    puts "You only got 3 flags, that means the fourth color is incorrect."
    puts "For example you get " + "R".colorize(:background => :light_red, :color => :black) + " " + 
    "W".colorize(:background => :light_white, :color => :black) + " " + 
    "W".colorize(:background => :light_white, :color => :black)
    puts "Which means: 1 color is correct and is on the right spot, "
    puts "and 2 other color also correct, but they are on the wrong spots."
    puts "Beware! Feedback flags do not indicate positions! So on the example above "
    puts "you don't know which of your color has got red or white or no flag."
    puts "You have 12 turns to guess and to win! "
    puts "Let's start!"

  end
end

class Guess
  def initialize
    @guess = gets.chomp.downcase
  end

  def check_guess(code,guess)
    flags = []
    binding.pry
    for i in 0..3 do
      if guess[i] == code[i]
        flags.push("red")
      else
        for j in 0..3
          if j == i 
            next
          end
          if guess[i] == code[j]
            flags.push("white")
          end
        end
        return flags
      end
    end
  end

  def value
    return @guess
  end
end

module GameMethods
  def self.start_game
    @game_over = false
    Intro.welcome
    player = Intro.get_player
    role = Intro.get_role
    # @code = Colors.pick_random
    Intro.show_instructions
  end
  
  def self.get_guess
    #for testing------
    @code = ["r","g","b","b"]
    #for testing------
    puts "\nYour guess is:"
    @guess = Guess.new
    # binding.pry
    until @guess.value.match(/[rgbymo]{4}/)
      puts "\nGive valid colors like GBYY or RMBG!".colorize(:color => :light_red)
      @guess = Guess.new
    end
    return @guess
  end

  
  def self.evaluate_guess
    if @guess.check_guess(@code,@guess.value)
      puts "dam, you are good"
    else
      puts "nope"
    end
  end
  
  def show_result

  end
end

#GameMethods.start_game()
GameMethods.get_guess()
GameMethods.evaluate_guess()

