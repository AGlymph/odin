class ConnectFourBoard
  attr_reader :rows, :columns, :grid

  def initialize(columns: 1, rows: 1, placeholder: ' ', grid: Array.new(columns){Array.new(rows) {placeholder}})
    @rows = rows
    @columns = columns
    @placeholder = placeholder
    @grid = grid
  end

  def show 
    puts "---"
    flipped_grid = @grid.map {|col| col.reverse}
    flipped_grid.transpose.each {|row| puts "| #{row.join(' | ')} |"}
    puts "---"
  end

  def insert_piece(column, piece)
    col_index = column - 1
    first_empty_index = @grid[col_index].index(@placeholder)
    return nil if first_empty_index.nil?
    @grid[col_index][first_empty_index] = piece
    return first_empty_index
  end
end


board = ConnectFourBoard.new(columns: 6,rows: 7)
board.show
board.insert_piece(2,'x')
board.insert_piece(2,'o')
board.insert_piece(2,'y')
board.show