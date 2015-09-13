module View

	def self.welcome
		"Welcome to my Tic Tac Toe game"
	end

	def self.options_menu
		"Welcome to the options menu! Have fun!"
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