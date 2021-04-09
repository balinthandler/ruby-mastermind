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
    skip_guess_array = []
    skip_code_array = []
    skip_count = 0
    guess = guess.split('')
    code.each_with_index {|code_color, color_idx|
      guess.each_with_index {|guessed_color, guessed_idx|
        if skip_guess_array.any? {|item| item == guessed_idx} 
          next
          end
        if code_color == guessed_color && color_idx == guessed_idx 
          flags.push("RED")
          skip_guess_array.push(guessed_idx)
          skip_code_array.push(color_idx)
          skip_count += 1
        end
      }
    }

    code.each_with_index {|code_color, color_idx|
      if skip_code_array.any? {|item| item == color_idx}
        next
      end 
      guess.each_with_index {|guessed_color, guessed_idx|
        if skip_guess_array.any? {|item| item == guessed_idx}
          next
        elsif code_color == guessed_color 
          flags.push("WHITE")
          skip_guess_array.push(guessed_idx)
          skip_count += 1
          next
        end
        
      }
    }
    return flags
  end

  def value
    return @guess
  end



end

module GameMethods
  def self.start_game
    Intro.welcome
    player = Intro.get_player
    role = Intro.get_role
    @code = Colors.pick_random
    Intro.show_instructions
    return @code
  end
  
  def self.get_guess
    puts "\nYour guess is:"
    @guess = Guess.new
    until @guess.value.match(/^[rgbymo]{4}$/)
      puts "\nGive valid colors like GBYY or RMBG!".colorize(:color => :light_red)
      @guess = Guess.new
    end
    return @guess
  end

  def self.show_guess
    message = ""
    arr = @guess.value.split('')
    arr.each { |color|
      if color == "r"
        message << "R".colorize(:background => :light_red, :color =>:black) + "  "
      elsif color == "g"
        message << "G".colorize(:background => :light_green, :color =>:black) + "  "
      elsif color == "b"
        message << "B".colorize(:background => :light_blue, :color =>:black) + "  "
      elsif color == "y"
        message << "Y".colorize(:background => :light_yellow, :color =>:black) + "  "
      elsif color == "m"
        message << "M".colorize(:background => :light_magenta, :color =>:black) + "  "
      elsif color == "o"
        message << "O".colorize(:background => :yellow, :color =>:black) + "  "
      end
    }
    return message
  end

  def self.show_code(code)
    message = ""
    code.each { |color|
      if color == "r"
        message << "R".colorize(:background => :light_red, :color =>:black) + "  "
      elsif color == "g"
        message << "G".colorize(:background => :light_green, :color =>:black) + "  "
      elsif color == "b"
        message << "B".colorize(:background => :light_blue, :color =>:black) + "  "
      elsif color == "y"
        message << "Y".colorize(:background => :light_yellow, :color =>:black) + "  "
      elsif color == "m"
        message << "M".colorize(:background => :light_magenta, :color =>:black) + "  "
      elsif color == "o"
        message << "O".colorize(:background => :yellow, :color =>:black) + "  "
      end
    }
    return message
  end
  
  def self.evaluate_guess
    flags = @guess.check_guess(@code,@guess.value)
    return flags

  end
  
  def self.show_feedback(flags)
    red = 0
    white = 0
    if flags.length < 1
      puts "None if the colors are in the code!"
    end
    flags.each { |flag|
      if flag == "RED" 
        red += 1
        print "RED".colorize(:background => :light_red, :color => :black) + " "
      else
        white += 1
        print "WHITE".colorize(:background => :light_white, :color => :black) + " "
      end
    }
    puts
    if red == 4
      puts "ALL OF THE COLORS ARE CORRECT"
      puts "THEY ARE IN THE RIGHT SPOTS !"
    elsif red > 1
      puts "#{red} colors are correct and are on the right spot"
    elsif red == 1
      puts "#{red} color is correct and is on the right spot"
    end
    if white > 1
      puts "#{white} colors are correct, but they are on the wrong spot"
    elsif white == 1
      puts "#{white} color is correct, but it is on the wrong spot"
    end
    return red
  end

end

def gameMechanisms
  gameover = false
  turn = 0
  code = GameMethods.start_game()
  until gameover
    guess = GameMethods.get_guess()
    flags = GameMethods.evaluate_guess()
    turn += 1
    puts
    puts "--------------------------------"
    # if win show the code
    if (flags.length == 4 && flags.all? { |flag| flag == "RED"}) || turn == 12
      gameover = true
      puts "T H E  C O D E: " + GameMethods.show_code(code)
    else
      puts "T H E  C O D E: ?  ?  ?  ? "
    end
    puts "YOUR GUESS:     " + GameMethods.show_guess
    puts "--------------------------------"
    if gameover && turn == 12
      puts " R U N S  O U T  O F  T U R N S ".colorize(:color => :light_red)
      puts "--------G A M E  O V E R--------".colorize(:color => :light_red)
    elsif gameover
      puts "C O N G R A T U L A T I O N S!".colorize(:color => :light_green)
      puts "---------Y O U  W O N---------".colorize(:color => :light_green)
    else
      puts "F E E D B A C K  F L A G S:"
      GameMethods.show_feedback(flags)
    end  


  end
end

gameMechanisms()

#kódot rosszul mutatja ha nyersz
