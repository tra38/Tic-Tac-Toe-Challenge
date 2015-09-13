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
    @player_one = Player.new(type: :human, symbol: "O")
    @player_two = Player.new(type: :computer, symbol: "X")
    @current_player = @player_one
    @next_player = @player_two
  end

  def has_ended?
    game_is_over(@board) || tie?(@board)
  end

  def get_next_move
    puts View.display_turn(@current_player.symbol)
    if @current_player.type == :human
      get_human_spot
    else
      get_computer_spot
    end
    self.next_player, self.current_player = self.current_player, self.next_player
  end

  def human_input
    gets.chomp
  end

  def get_human_spot
    spot = human_input
    if valid_move?(spot)
      @board[spot.to_i] = @current_player.symbol
      puts View.spot_picked(@current_player.symbol, spot)
    else
      puts View.display_error(spot)
      get_human_spot
    end
  end

  def valid_move?(spot)
    (0..8).include?(spot.to_i) && @board[spot.to_i] != (@player_one.symbol) && @board[spot.to_i] != (@player_two.symbol) && spot.to_i.to_s == spot.to_s
  end

  def get_computer_spot
    spot = nil
    until spot
      if @board[4] == "4"
        spot = 4
        @board[spot] = @current_player.symbol
      else
        spot = current_player.fitness_calculator(opponent: self.next_player, board: self.board)
        self.board[spot] = @current_player.symbol
      end
    end
    puts View.spot_picked(@current_player.symbol, spot)
  end
end