require_relative 'status_checking'
require_relative 'fitness_calculator'
require_relative 'view'

class Game
  attr_reader :board, :fitness
  include StatusChecking

  def initialize(board)
    @board = board
    @com = "X"
    @hum = "O"
    @fitness = FitnessCalculator.new(board: board, com: @com, hum: @hum)
  end

  def has_ended?
    game_is_over(@board) || tie?(@board)
  end

  def get_human_spot
    spot = gets.chomp.to_i
    if (@board[spot] != "X" && @board[spot] != "O" && (0..9).include?(spot) )
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