require_relative '../lib/game.rb'

RSpec.describe Game do
  before(:all) {
    @board = Board.new
    @game = Game.new(@board)
  }
	it "starts with a blank board" do
		expect(@game.board.to_s).to eq ("|_0_|_1_|_2_|\n|_3_|_4_|_5_|\n|_6_|_7_|_8_|\n")
	end
end