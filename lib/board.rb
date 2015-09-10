class Board
	attr_accessor :board

	def initialize
		@board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
	end

	def to_s
		"|_#{board[0]}_|_#{board[1]}_|_#{board[2]}_|\n|_#{board[3]}_|_#{board[4]}_|_#{board[5]}_|\n|_#{board[6]}_|_#{board[7]}_|_#{board[8]}_|\n"
	end

end