require_relative '../lib/game.rb'
require_relative '../lib/board.rb'
require 'stringio'

RSpec.describe Game do
  before(:all) {
    @board = Board.new
    @game = Game.new(@board.board)
  }
	it "starts with a blank board" do
		expect(@game.board).to eq(["0","1","2","3","4","5","6","7","8"])
	end

  context "allows humans to make moves" do
    it "allows player to move" do
      allow(@game).to receive(:human_input) { 2 }
      @game.get_human_spot
      expect(@game.board).to eq(["0","1","O","3","4","5","6","7","8"])
    end
  end

end