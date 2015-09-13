module View

	def self.welcome
		"Welcome to my Tic Tac Toe game"
	end

	def self.options_menu(options_hash)
		player_one = options_hash[:player_one]
		player_two = options_hash[:player_two]

		<<-eos

		0 - Let's play!
		1 - Allow #{player_two.symbol} go first!

		eos
	end

	def self.current_options(options_hash)
		"HI!"
		# player_one = options_hash[:player_one]
		# player_two = options_hash[:player_two]
		# <<-eos This will be a #{player_one.symbol} (#{player_one.type}) versus a #{player_two.symbol} (#{player_two.type}) match. #{player_one.symbol} will go first.
		# eos
	end

	def self.invalid_option_selection(input)
		"I am sorry but #{input} is an invalid selection. Please try again."
	end

	def self.instructions
		"Please select your spot. Only the spaces between 0-8"
	end

	def self.game_over
		"Game over"
	end

	def self.display_turn(symbol)
		"It is now #{symbol}'s Turn."
	end

	def self.spot_picked(symbol, spot)
		"#{symbol} has picked Spot #{spot}."
	end

	def self.display_error(spot)
		"I am sorry, but Spot #{spot} is an invalid choice to make. Please make another selection."
	end

end