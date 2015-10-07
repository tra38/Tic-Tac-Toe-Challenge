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
	game.get_next_move
	sleep(1.25)
	View.clear
	View.display_board(board)
end

View.game_over