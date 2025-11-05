require_relative 'connect_four_board'

class ConnectFour 
  
  grid = [['0','1','2','x'], ['0','1','x','2'], ['0','x','1','?']]
  board = ConnectFourBoard.new(columns: 6,rows: 7, grid:grid)
  board.show
  board.chain_length([1,1], 'x') # this goes outof bounds and wraprs.Works when set to 2 2
  # board.insert_piece(2,'x')
  # board.insert_piece(2,'o')
  # board.insert_piece(2,'y')
  # board.show
end

game = ConnectFour.new();
# have a grid 7long by 6 tall
# two players @ and # 
# each player takes a turn to sellect a column 
# the piece drops down to the last available slot 
# player wins they connec four in a row: horizontally, diagonally, or vertically 
# 
#
# graph 
# each slot is a node
# each node can hold one piece
# each node has an edge to their adjacent nodes
# 