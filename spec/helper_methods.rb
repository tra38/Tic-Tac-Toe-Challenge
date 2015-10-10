# #This "medium_ai" was the original implementation of the "Tic-Tac Toe" AI, before we had to rewrite it.
def medium_ai(board)
  duplicate_board = board.dup
  available_spaces = []
  best_move = nil
  duplicate_board.each do |s|
    if s != "X" && s != "O"
      available_spaces << s
    end
  end
  available_spaces.each do |as|
    index = as.to_i - 1
    duplicate_board[index] = "X"
    if @game.someone_won?(board)
      best_move = as.to_i
      duplicate_board[index] = as
      return best_move
    else
      duplicate_board[index] = "O"
      if @game.someone_won?(board)
        best_move = as.to_i
        return best_move
      else
        duplicate_board[index] = as
      end
    end
  end
  available_spaces.sample
end
