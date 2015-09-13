class Player
  attr_accessor :type, :symbol

  def initialize(args)
    @symbol = args[:symbol]
    @type = args[:type]
  end

  def to_s
    @symbol
  end

  def fitness_calculator(args)
    fitness = FitnessCalculator.new(computer: self, opponent: args[:opponent])
    fitness.get_best_move(self.symbol, args[:board])
  end

end