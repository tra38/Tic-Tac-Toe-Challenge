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
		return as if @game.someone_won?(duplicate_board)
		duplicate_board[index] = "O"
		return as if @game.someone_won?(duplicate_board)
		duplicate_board[index] = as
	end
	available_spaces.sample
end
