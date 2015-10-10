require_relative '../lib/game.rb'
require_relative '../lib/board.rb'
require_relative 'helper_methods.rb'
require 'stringio'


RSpec.describe "Hard AI" do
  it "will successfully beat or tie the Medium AI 25 times" do
    25.times do |number|
      @board = Board.new
      @game = Game.new( {board: @board.board, player_one: Player.new(type: :human, symbol: "X"), player_two: Player.new(type: :computer, symbol: "O")} )
      allow(@game).to receive(:human_input) { medium_ai(@game.board) }
      until @game.has_ended?
        @game.get_next_move
        @game.switch_players
      end
      if (@game.someone_won?(@board.board))
        expect(@game.next_player.type).to eq(:computer)
      else
        expect(@game.tie?(@board.board)).to eq(true)
      end
    end
  end

  it "will only tie when playing against itself" do
  	@board = Board.new
  	@game = Game.new( {board: @board.board, player_one: Player.new(type: :computer, symbol: "O"), player_two: Player.new(type: :computer, symbol: "X")} )
    9.times { @game.get_next_move; @game.switch_players }
    expect(@game.tie?(@board.board)).to eq(true)
    expect(@game.someone_won?(@board.board)).to eq(false)
  end
end