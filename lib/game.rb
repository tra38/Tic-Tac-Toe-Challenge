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
    @com = Player.new(type: :computer, symbol: "X")
    @hum = Player.new(type: :human, symbol: "O")
    @fitness = FitnessCalculator.new(board: board, com: @com, hum: @hum)
    @current_player = @hum
    @next_player = @com
  end

  def has_ended?
    game_is_over(@board) || tie?(@board)
  end

  def get_next_move
    if @current_player.type == :human
      get_human_spot
    else
      get_computer_spot
    end
    self.next_player, self.current_player = self.current_player, self.next_player
  end

  def get_human_spot
    spot = gets.chomp.to_i
    if (@board[spot] != @com && @board[spot] != @hum && (0..9).include?(spot) )
      @board[spot] = @hum
    else
      puts View.display_error(spot)
      get_human_spot
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