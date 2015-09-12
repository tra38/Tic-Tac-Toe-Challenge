require_relative 'status_checking'

class FitnessCalculator
  attr_reader :com, :hum
  attr_accessor :fitness

  include StatusChecking

  def initialize(args)
    @com_symbol = args[:com].symbol
    @hum_symbol = args[:hum].symbol
    @fitness = nil
  end

  def calcuate_available_spaces(board)
    array = []
    board.each do |s|
      if s != @com_symbol && s != @hum_symbol
        array << s
      end
    end
    array
  end

  def computer_can_win?(future_board, space)
    p future_board
    future_board[space.to_i] = @com_symbol
    return true if game_is_over(future_board)
  end

  def human_can_win?(future_board, space)
    future_board[space.to_i] = @hum_symbol
    return true if game_is_over(future_board)
  end

  def increase_fitness_for_winning(original_move)
    fitness[original_move] += 10
  end

  def decrease_fitness_for_losing(original_move)
    fitness[original_move] -= 10
  end

#If the depth is 0, this method is called, telling the AI to priortize making this move...
#because making this move will either cause the AI to win automatically or prevent the
#other player from winning. When forced between choosing between a move that will
#stop a player from winning (fitness: 990) or a move that will cause the AI to win (fitness: 1010),
#the AI will choose to do the move that will casue it to win.
  def priortize_this_move(original_move)
    fitness[original_move] += 1000
  end

  def get_best_move(current_player, board)
    self.fitness = Hash.new(0)
    examine_possible_moves(current_player, board)
    puts fitness
    best_moves = fitness.select { |k,v| v == fitness.values.max }
    (best_moves.keys.sample).to_i
  end

  def examine_possible_moves(current_player, board)
    available_spaces = calcuate_available_spaces(board)
    available_spaces.each do |space|
      evaluate_fitness_of_space(space, board, current_player)
    end
  end

  def evaluate_fitness_of_space(space, board, current_player, original_move=space, depth=0)
    if current_player == @com_symbol
      next_player = @hum_symbol
    else
      next_player = @com_symbol
    end
    future_board = board.dup
    if computer_can_win?(future_board, space)
      priortize_this_move(original_move) if depth == 0
      increase_fitness_for_winning(original_move)
    elsif human_can_win?(future_board, space)
      priortize_this_move(original_move) if depth == 0
      decrease_fitness_for_losing(original_move)
    elsif tie?(future_board)
      fitness[original_move] = 0
    else
      future_board[space.to_i] = current_player
      dig_deeper_into_tree(next_player, future_board, original_move, depth+1)
    end
  end

  def dig_deeper_into_tree(current_player, future_board, original_move, depth)
    available_spaces = calcuate_available_spaces(future_board)
    available_spaces.each do |space|
      evaluate_fitness_of_space(space, future_board, current_player, original_move, depth)
    end
  end

end