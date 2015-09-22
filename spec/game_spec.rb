require_relative '../lib/game.rb'
require_relative '../lib/board.rb'
require 'stringio'

RSpec.describe Game do
  before(:each) {
    @board = Board.new
    @game = Game.new( {board: @board.board, player_one: Player.new(type: :human, symbol: "O"), player_two: Player.new(type: :computer, symbol: "X")} )
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

RSpec.describe Game do
  before(:all) do
  @board = Board.new
  @game = Game.new( {board: @board.board, player_one: Player.new(type: :computer, symbol: "O"), player_two: Player.new(type: :computer, symbol: "X")} )
  end

  it "ensures no one wins in a match between two computers" do
    9.times { @game.get_next_move }
    expect(@game.tie?(@board.board)).to eq(true)
    expect(@game.someone_won?(@board.board)).to eq(false)
  end

end

# #This "medium_ai" was the original implementation of the "Tic-Tac Toe" AI, before we had to rewrite it.
def medium_ai(board)
  available_spaces = []
  best_move = nil
  board.each do |s|
    if s != "X" && s != "O"
      available_spaces << s
    end
  end
  available_spaces.each do |as|
    board[as.to_i] = "X"
    if @game.someone_won?(board)
      best_move = as.to_i
      board[as.to_i] = as
      return best_move
    else
      board[as.to_i] = "O"
      if @game.someone_won?(board)
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = as
      end
    end
  end
  if best_move
    return best_move
  else
    n = rand(0..available_spaces.count)
    return available_spaces[n].to_i
  end
end
RSpec.describe Game do
  it "will successfully beat a random AI 100 times" do
    100.times do
      @board = Board.new
      @game = Game.new( {board: @board.board, player_one: Player.new(type: :human, symbol: "X"), player_two: Player.new(type: :computer, symbol: "O")} )
      @game.stub(:human_input) { medium_ai(@game.board) }
      9.times { @game.get_next_move; break if @game.has_ended? }
      puts @board
      if (@game.someone_won?(@board.board))
        expect(@game.next_player.type).to eq(:computer)
      else
        expect(@game.tie?(@board.board)).to eq(true)
      end
    end
  end
end