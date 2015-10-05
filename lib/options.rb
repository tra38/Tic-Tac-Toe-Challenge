module Options
  attr_accessor :options_hash

  def self.set_options(board)
    Options.create_options_hash(board)
    Options.modify_options
    return @options_hash
  end

  def self.create_options_hash(board)
    View.choose_type_of_match
    input = gets.chomp
    case input
    when "1"
      @options_hash = { board: board.board, player_one: Player.new(type: :human, symbol: "O"), player_two: Player.new(type: :human, symbol: "X") }
    when "2"
      @options_hash = { board: board.board, player_one: Player.new(type: :human, symbol: "O"), player_two: Player.new(type: :computer, symbol: "X") }
    when "3"
      @options_hash = { board: board.board, player_one: Player.new(type: :computer, symbol: "O"), player_two: Player.new(type: :computer, symbol: "X") }
    else
      View.invalid_option_selection(input)
      create_options_hash(board)
    end
  end

  def self.change_symbols
    View.change_symbol(@options_hash[:player_one])
    @options_hash[:player_one].symbol = gets.chomp
    View.change_symbol(@options_hash[:player_two])
    @options_hash[:player_two].symbol = gets.chomp
  end

  def self.modify_options
    View.current_options(@options_hash)
    View.options_menu(@options_hash)
    input = gets.chomp
    case input
    when "1"
    when "2"
      @options_hash[:player_one], @options_hash[:player_two] = @options_hash[:player_two], @options_hash[:player_one]
      modify_options
    when "3"
      change_symbols
      modify_options
    else
      View.invalid_option_selection(input)
      modify_options
    end
  end

end