require_relative 'status_checking'

class FitnessCalculator
  attr_reader :computer, :opponent
  attr_accessor :current_player, :next_player

  include StatusChecking

  def initialize(args)
    @computer = args[:computer]
    @opponent = args[:opponent]
    @current_player = @computer
    @next_player = @opponent
  end

  def calcuate_available_spaces(board)
    array = []
    board.each do |s|
      if s != @computer.symbol && s != @opponent.symbol
        array << s
      end
    end
    array
  end

  def get_best_moves(board)
    if calcuate_available_spaces(board).include?("4") 
      "4"
    else
      fitness = examine_possible_moves(board)
      best_moves = fitness.select { |k,v| v == fitness.values.max }
      best_moves.keys[0]
    end
  end

  def examine_possible_moves(board)
    fitness = Hash.new(0)
    available_spaces = calcuate_available_spaces(board)
    available_spaces.each do |space|
      fitness[space] = evaluate_fitness_of_space(space, board)
    end
    fitness
  end

  def evaluate_fitness_of_space(space, board)
    future_board = board.dup
    if computer_can_win?(future_board, space)
      return 10
    else
      future_board[space.to_i] = current_player.symbol
      return 0 if tie?(future_board)
      dig_deeper_into_tree(future_board)
    end
  end

  def computer_can_win?(future_board, space)
    future_board[space.to_i] = computer.symbol
    return true if someone_won?(future_board)
  end

  def opponent_can_win?(future_board, space)
    future_board[space.to_i] = opponent.symbol
    return true if someone_won?(future_board)
  end

  def dig_deeper_into_tree(future_board)
    enemy_move = opponent.fitness_calculator(opponent: computer, board: future_board)
    if opponent_can_win?(future_board, enemy_move)
      return -10
    else
      future_board[enemy_move.to_i] = opponent.symbol
      return 0 if tie?(future_board)
      our_move = computer.fitness_calculator(opponent: opponent, board: future_board)
      evaluate_fitness_of_space(our_move, future_board)
    end
  end

end