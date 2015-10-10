require_relative '../lib/game.rb'
require_relative '../lib/board.rb'
require_relative 'helper_methods.rb'

RSpec.describe "Medium AI" do
	before(:each) {
	  @board = Board.new
	  @game = Game.new( {board: @board.board, player_one: Player.new(type: :human, symbol: "O"), player_two: Player.new(type: :human, symbol: "X")} )
	  allow(@game).to receive(:human_input) { medium_ai(@game.board) }
	}

	it "The Medium AI will always choose valid moves" do
		10.times do
			expect(View).to_not receive(:display_error)
			until @game.has_ended?
				@game.get_next_move
				@game.switch_players
			end
		end
	end
end