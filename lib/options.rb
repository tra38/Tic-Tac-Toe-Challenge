class Options
	attr_accessor :options_hash

	def initialize(board)
		@options_hash = {}
		create_options_hash(board)
		modify_options
	end

	def create_options_hash(board)
		View.choose_type_of_match
		input = gets.chomp
		case input
		when "1"
			@options_hash = { board: board.board, player_one: Player.new(type: :human, symbol: "O"), player_two: Player.new(type: :human, symbol: "X") }
		when "2"
			@options_hash = { board: board.board, player_one: Player.new(type: :human, symbol: "O"), player_two: Player.new(type: :computer, symbol: "X") }
		when "3"
			@options_hash = { board: board.board, player_one: Player.new(type: :computer, symbol: "O"), player_two: Player.new(type: :computer, symbol: "X") }
		else
			View.invalid_option_selection(input)
			create_options_hash(board)
		end
	end

	def change_symbols
		View.change_symbol(@options_hash[:player_one])
		player_one_symbol = gets.chomp
		View.change_symbol(@options_hash[:player_two])
		player_two_symbol = gets.chomp
		if player_one_symbol == player_two_symbol
			View.symbol_error
			change_symbols
		else
			@options_hash[:player_one].symbol = player_one_symbol
			@options_hash[:player_two].symbol = player_two_symbol
		end
	end

	def modify_options
		View.current_options(@options_hash)
		View.options_menu(@options_hash)
		input = gets.chomp
		case input
		when "1"
		when "2"
			@options_hash[:player_one], @options_hash[:player_two] = @options_hash[:player_two], @options_hash[:player_one]
			modify_options
		when "3"
			change_symbols
			modify_options
		else
			View.invalid_option_selection(input)
			modify_options
		end
	end

end