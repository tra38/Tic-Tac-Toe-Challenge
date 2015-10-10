require_relative '../lib/game.rb'
require_relative '../lib/board.rb'
require_relative 'helper_methods.rb'

RSpec.describe "Medium AI" do

	it "will always choose valid moves" do
		10.times do
			@board = Board.new
			@game = Game.new( {board: @board.board, player_one: Player.new(type: :human, symbol: "O"), player_two: Player.new(type: :human, symbol: "X")} )
			allow(@game).to receive(:human_input) { medium_ai(@game.board) }
			expect(View).to_not receive(:display_error)
			until @game.has_ended?
				@game.get_next_move
				@game.switch_players
			end
		end
	end

	it "will choose a move if that move will lead to victory" do
		@board = Board.new
		@board.board = ["O", "O", "3", "4", "5", "6", "7", "8", "9"]
		@game = Game.new( {board: @board.board, player_one: Player.new(type: :human, symbol: "O"), player_two: Player.new(type: :computer, symbol: "X")} )
		allow(@game).to receive(:human_input) { medium_ai(@game.board) }
		@game.get_next_move
		expect(@game.board).to eq(["O","O","O","4","5","6","7","8","9"])
	end

	it "will choose a move that will stop an opponent from winnings" do
		@board = Board.new
		@board.board = ["X", "X", "3", "4", "5", "6", "7", "8", "9"]
		@game = Game.new( {board: @board.board, player_one: Player.new(type: :human, symbol: "O"), player_two: Player.new(type: :computer, symbol: "X")} )
		allow(@game).to receive(:human_input) { medium_ai(@game.board) }
		@game.get_next_move
		expect(@game.board).to eq(["X","X","O","4","5","6","7","8","9"])
	end


end