require_relative 'status_checking'
require 'pry'

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
    fitness = examine_possible_moves(board)
    p fitness
    best_moves = fitness.select { |k,v| v == fitness.values.max }
    p best_moves
    p best_moves.keys[0]
    best_moves.keys[0]
  end
  # Consider only selecting one best_move, since it may not matter what move is better

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



  # def get_best_move(current_player, board)
  #   self.fitness = Hash.new(0)
  #   examine_possible_moves(current_player, board)
  #   best_moves = fitness.select { |k,v| v == fitness.values.max }
  #   (best_moves.keys.sample).to_i
  # end

  # enemy_moves = opponent.fitness_calculator(computer: opponent, opponent: computer, board: future_board)


  # def evaluate_fitness_of_space(space, board, current_player, original_move=space, depth=0)
  #   if current_player == @computer.symbol
  #     next_player = @opponent.symbol
  #   else
  #     next_player = @computer.symbol
  #   end
  #   future_board = board.dup
  #   if computer_can_win?(future_board, space)
  #     priortize_this_move(original_move) if depth == 0
  #     increase_fitness_for_winning(original_move)
  #   elsif opponent_can_win?(future_board, space)
  #     priortize_this_move(original_move) if depth == 0
  #     decrease_fitness_for_losing(original_move)
  #   elsif tie?(future_board)
  #     fitness[original_move] = 0
  #   else
  #     future_board[space.to_i] = current_player
  #     dig_deeper_into_tree(next_player, future_board, original_move, depth+1)
  #   end
  # end

  # def dig_deeper_into_tree(current_player, future_board, original_move, depth)
  #   enemy_move = FitnessCalculator.new(computer: self.next_player, opponent: self.current_player).get_best_move(self.next_player.symbol, future_board)
  #   future_board[enemy_move] = self.next_player.symbol
  #   available_spaces = calcuate_available_spaces(future_board)
  #   available_spaces.each do |space|
  #     evaluate_fitness_of_space(space, future_board, current_player, original_move, depth + 1)
  #   end
  # end

end