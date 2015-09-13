class Player
  attr_reader :type, :symbol

  def initialize(args)
    @symbol = args[:symbol]
    @type = args[:type]
  end

  def to_s
    @symbol
  end

  def fitness_calculator(opponent: opponent, board: board)
    fitness = FitnessCalculator.new(computer: self, opponent: opponent)
    fitness.get_best_move(self.symbol, board)
  end

end