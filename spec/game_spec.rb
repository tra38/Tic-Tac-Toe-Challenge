require_relative '../lib/game.rb'
require_relative '../lib/board.rb'
require 'stringio'

RSpec.describe Game do
  before(:each) {
    @board = Board.new
    @game = Game.new(@board.board)
  }
	it "starts with a blank board" do
		expect(@game.board).to eq(["0","1","2","3","4","5","6","7","8"])
	end

  context "allows humans to make moves" do
    it "- allows player to move" do
      allow(@game).to receive(:human_input).and_return(2)
      @game.get_human_spot
      expect(@game.board).to eq(["0","1","O","3","4","5","6","7","8"])
    end
  end

  context "rejects invalid moves by humans" do
    it "- rejects 10 as an invalid input" do
      allow(@game).to receive(:human_input).and_return(10,5)
      expect(View).to receive(:display_error).with(10)
      @game.get_human_spot
    end

    it "- rejects 9 as an invalid input" do
      allow(@game).to receive(:human_input).and_return(9,5)
      expect(View).to receive(:display_error).with(9)
      @game.get_human_spot
    end

    it "- rejects words as an invalid input" do
      allow(@game).to receive(:human_input).and_return("dog",5)
      expect(View).to receive(:display_error).with("dog")
      @game.get_human_spot
    end

    it "- reject spaces already taken" do
      allow(@game).to receive(:human_input).and_return(5,5,6)
      expect(View).to receive(:display_error).with(5)
      2.times { @game.get_human_spot }
    end
  end

  context "allows computer to make moves" do
    it "- successfully makes move after the human" do
      allow(@game).to receive(:human_input).and_return(2)
      2.times { @game.get_next_move }
      expect(@game.board).to eq(["0","1","O","3","X","5","6","7","8"])
    end
  end

end