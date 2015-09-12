class Player
  attr_reader :type, :symbol

  def initialize(args)
    @symbol = args[:symbol]
    @type = args[:type]
  end

  def to_s
    @symbol
  end

end