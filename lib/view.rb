module View

	def self.welcome
		puts "Welcome to my Tic Tac Toe game"
	end

	def self.choose_type_of_match
		puts <<-eos
		Choose what type of match you want to play:

		1 - Human versus Human
		2 - Human versus Computer
		3 - Computer versus Computer
		eos
	end

	def self.options_menu(options_hash)
		player_one = options_hash[:player_one]
		player_two = options_hash[:player_two]

		puts <<-eos

		1 - Let's play!
		2 - Allow #{player_two.symbol} to go first!
		3 - Change the symbols!

		eos
	end

	def self.current_options(options_hash)
		player_one = options_hash[:player_one]
		player_two = options_hash[:player_two]
		puts <<-eos "This will be a #{player_one.symbol} (#{player_one.type}) versus a #{player_two.symbol} (#{player_two.type}) match. #{player_one.symbol} will go first."
		eos
	end

	def self.change_symbol(symbol)
		puts "Type in the new symbol to replace #{symbol}"
	end

	def self.symbol_error
		puts "You cannot select the same symbol twice! Plelase choose different symbols for each player."
	end

	def self.invalid_option_selection(input)
		puts "I am sorry but #{input} is an invalid selection. Please try again."
	end

	def self.instructions
		puts "Please select your spot. Only the spaces between 1-9"
	end

	def self.game_over
		puts "Game over"
	end

	def self.display_turn(symbol)
		puts "It is now #{symbol}'s Turn."
	end

	def self.spot_picked(symbol, spot)
		puts "#{symbol} has picked Spot #{spot}."
	end

	def self.display_error(spot)
		puts "I am sorry, but Spot #{spot} is an invalid choice to make. Please make another selection."
	end

	#clear the screen, only works on ANSI-supported screens (source: http://stackoverflow.com/a/263650)
	def self.clear
		puts "\e[H\e[2J"
	end

	def self.display_thinking(symbol)
		puts "#{symbol} is thinking..."
	end

	def self.display_board(board)
		puts board
	end

end