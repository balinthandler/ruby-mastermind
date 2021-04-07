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
  @colors = ["red", "green", "blue", "yellow", "orange", "purple"]

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
      sleep 1
      puts "to play as CodeBreaker, type \"B\", or to play as CodeMaker, type \"M\", and press ENTER!"
      role = gets.chomp.upcase
      if role == "B" || role == "M"
        return role
      end
    end
  end

  def self.show_instructions
    puts "\n--Creating code--"
    sleep 0.5
    puts "    ? ? ? ?"
    sleep 0.2
    puts "--Code created--"
    sleep 1
    puts "Try to guess the colors in the 4 slots!"
    puts "Available colors are: "     + " Red ".colorize(:background => :light_red) + " " +
      " Green ".colorize(:background => :light_green) + " " +
      " Blue ".colorize(:background => :blue) + " " +
      " Yellow ".colorize(:background => :light_yellow) + " " +
      " Magenta ".colorize(:background => :light_magenta) + " " +
      " Orange ".colorize(:background => :yellow)
    puts "One color could take multiple spots."
    puts "To guess, type only the initials, e.g. R for red, G for green etc.."
    puts "You have 12 turns to guess!"
    puts "Enter a pattern like this: G R B Y"
  end
end

module Guess
  def self.get_guess
    guess = gets.chomp.gsub(" ", "").upcase
    return guess
  end

  
end
def game
  Intro.welcome
  player = Intro.get_player
  role = Intro.get_role
  code = Colors.pick_random
  Intro.show_instructions


end

game()

