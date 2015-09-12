require_relative 'status_checking'
require_relative 'fitness_calculator'
require_relative 'view'
require_relative 'player'

class Game
  attr_reader :board, :fitness
  attr_accessor :current_player, :next_player
  include StatusChecking

  def initialize(board)
    @board = board
    @player_one = Player.new(symbol: "O", type: :human )
    @player_two = Player.new(symbol: "X", type: :computer )
    @fitness = FitnessCalculator.new(board: board, player_one: @player_one, player_two: @player_two)
    @current_player = @player_one
    @next_player = @player_two
  end

  def has_ended?
    game_is_over(@board) || tie?(@board)
  end

  def get_next_move
    if current_player.type == :human
      get_human_spot(current_player)
    else
      get_computer_spot
    end
    self.current_player, self.next_player = self.next_player, self.current_player
  end

  def get_human_spot(current_player)
    spot = gets.chomp.to_i
    if (@board[spot] != @com && @board[spot] != @hum && (0..8).include?(spot) )
      @board[spot] = current_player
    else
      puts View.display_error(spot)
      get_human_spot(current_player)
    end
  end

  def get_computer_spot
    spot = nil
    until spot
      if @board[4] == "4"
        spot = 4
        @board[spot] = @com
      else
        spot = fitness.get_best_move(@com, board)
        self.board[spot] = @com
      end
    end
  end
end