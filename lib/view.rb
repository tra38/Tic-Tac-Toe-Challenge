module View

	def self.welcome
		"Welcome to my Tic Tac Toe game"
	end

	def self.instructions
		"Please select your spot. Only the spaces between 0-8"
	end

	def self.game_over
		"Game over"
	end

	def self.display_error(spot)
		"I am sorry, but Spot #{spot} is an invalid choice to make. Please make another selection."
	end

end