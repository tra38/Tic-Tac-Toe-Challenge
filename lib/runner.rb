require_relative 'game'
require_relative 'board'
require_relative 'view'
require_relative 'options'

board = Board.new

View.clear

View.welcome
values = Options.new(board).options_hash

game = Game.new(values)

View.clear

View.display_board(board)
View.instructions

until game.has_ended?
	View.display_turn(game.current_player.symbol)
	View.display_thinking(game.current_player.symbol) if (game.current_player.type == :computer)
	spot = game.get_next_move
	View.spot_picked(game.current_player.symbol, spot)
	game.switch_players
	sleep(1.25)
	View.clear
	View.display_board(board)
end

View.game_over