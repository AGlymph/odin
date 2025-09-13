class ConnectFourBoard
  attr_reader :rows, :columns, :grid

  def initialize(columns = 1, rows = 1)
    @rows = rows
    @columns = columns
    @grid = Array.new(columns) {Array.new(rows) {' '}}
  end

  def show 
    @grid.transpose.each {|row| puts row.join(' | ')}
  end
end


board = ConnectFourBoard.new(6,3)
board.show