module Options

  def self.set_options(board)
    @board = board
    puts View.options_menu
    return {board: @board.board}
  end

end