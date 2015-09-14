require_relative 'game'
require_relative 'board'
require_relative 'view'
require_relative 'options'

board = Board.new

puts View.clear

puts View.welcome
values = Options.set_options(board)

game = Game.new(values)

puts View.clear

puts board
puts View.instructions

until game.has_ended?
	game.get_next_move
  sleep(1.25)
  puts View.welcome
  puts board
end

puts View.game_over