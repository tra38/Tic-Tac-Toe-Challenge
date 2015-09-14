require_relative 'status_checking'
require_relative 'fitness_calculator'
require_relative 'view'
require_relative 'player'

class Game
  attr_reader :board, :fitness
  attr_accessor :current_player, :next_player
  include StatusChecking

  def initialize(args)
    @board = args[:board]
    @current_player = args[:player_one]
    @next_player = args[:player_two]
  end

  def has_ended?
    game_is_over?(board) || tie?(board)
  end

  def get_next_move
    puts View.display_turn(current_player.symbol)
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
    spot = (human_input)
    if valid_move?(spot)
      self.board[spot.to_i] = current_player.symbol
      puts View.spot_picked(self.current_player.symbol, spot)
    else
      puts View.display_error(spot)
      get_human_spot
    end
  end

  def valid_move?(spot)
    (0..8).include?(spot.to_i) && board[spot.to_i] != (self.current_player.symbol) && board[spot.to_i] != (self.next_player.symbol) && spot.to_i.to_s == spot.to_s
  end

  def get_computer_spot
    spot = nil
    until spot
      if board[4] == "4"
        spot = 4
        self.board[spot] = current_player.symbol
      else
        spot = current_player.fitness_calculator(opponent: self.next_player, board: self.board)
        self.board[spot] = current_player.symbol
      end
    end
    puts View.spot_picked(current_player.symbol, spot)
  end
end