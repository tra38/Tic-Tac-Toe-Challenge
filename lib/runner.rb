require_relative 'game'
require_relative 'board'
require_relative 'view'

board = Board.new
game = Game.new(board.board)

puts board
puts View.welcome
puts View.instructions

until game.has_ended?
	game.get_next_move
	# game.get_computer_spot unless game.has_ended?
	puts board
end

puts View.game_over