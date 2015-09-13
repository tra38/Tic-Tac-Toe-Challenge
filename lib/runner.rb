require_relative 'game'
require_relative 'board'
require_relative 'view'
require_relative 'options'

board = Board.new

values = Options.set_options(board)

game = Game.new(values)

puts "\e[H\e[2J" #clear the screen, only works on ANSI-supported screens (source: http://stackoverflow.com/a/263650)

puts board
puts View.welcome
puts View.instructions

until game.has_ended?
	game.get_next_move
  sleep(1.25)
  puts "\e[H\e[2J"
  puts board
end

puts View.game_over