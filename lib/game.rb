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
    someone_won?(board) || tie?(board)
  end

  def get_next_move
    if current_player.type == :human
      get_human_spot
    else
      get_computer_spot
    end
    self.next_player, self.current_player = self.current_player, self.next_player
  end

  def translate_spot_to_index(spot)
    spot.to_i - 1
  end

  def translate_index_to_spot(index)
    index.to_i + 1
  end

  def human_input
    gets.chomp
  end

  def get_human_spot
    spot = (human_input)
    index = translate_spot_to_index(spot)
    if valid_move?(index)
      self.board[index] = current_player.symbol
      View.spot_picked(self.current_player.symbol, spot)
    else
      View.display_error(spot)
      get_human_spot
    end
  end

  def valid_move?(index)
    (0..8).include?(index.to_i) && board[index.to_i] != (self.current_player.symbol) && board[index.to_i] != (self.next_player.symbol) && index.to_i.to_s == index.to_s
  end

  def get_computer_spot
    View.display_thinking(current_player.symbol)
    index = current_player.fitness_calculator(opponent: self.next_player, board: self.board)
    self.board[index.to_i] = current_player.symbol
    spot = translate_index_to_spot(index)
    View.spot_picked(current_player.symbol, spot)
  end
end