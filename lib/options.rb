module Options
  attr_accessor :options_hash

  def self.set_options(board)
    Options.set_default_options(board)
    Options.get_user_input
    return @options_hash
  end

  def self.set_default_options(board)
    @options_hash = { board: board.board, player_one: Player.new(type: :human, symbol: "O"), player_two: Player.new(type: :computer, symbol: "X") }
  end

  def self.get_user_input
    puts View.current_options(@options_hash)
    puts View.options_menu(@options_hash)
    input = gets.chomp
    case input
    when "0"
    when "1"
      @options_hash[:player_one], @options_hash[:player_two] = @options_hash[:player_two], @options_hash[:player_one]
      get_user_input
    else
      View.invalid_option_selection(input)
      get_user_input
    end
  end

end