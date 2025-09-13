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
    flipped_grid.transpose.each_with_index {|row, index| puts "#{index  + 1}: | #{row.join(' | ')} |"}
    puts "---"
  end

  def insert_piece(column, piece)
    col_index = column - 1
    first_empty_index = @grid[col_index].index(@placeholder)
    return nil if first_empty_index.nil?
    @grid[col_index][first_empty_index] = piece
    return first_empty_index
  end

  def chain_length(position, piece)
    flipped_grid = @grid.map {|col| col.reverse}
    col_index = position[0] - 1
    row_index = position[1] - 1
    column = flipped_grid[col_index]
    column_string = column.join
    row = flipped_grid.transpose[row_index]
    row_string = row.join

    

    left_right_diagonal = [flipped_grid[col_index-1][row_index-1], flipped_grid[col_index][row_index], flipped_grid[col_index+1][row_index+1]]
    p left_right_diagonal
    4.downto(1) do |n|
      check_chain = piece*n
      return n if (column_string.include?(check_chain) || row_string.include?(check_chain))
    end
    return 0
  end
end

grid = [['0','1','2','x'], ['0','1','x','2'], ['0','x','1','?']]
board = ConnectFourBoard.new(columns: 6,rows: 7, grid:grid)
board.show
board.chain_length([1,1], 'x') # this goes outof bounds and wraprs.Works when set to 2 2
# board.insert_piece(2,'x')
# board.insert_piece(2,'o')
# board.insert_piece(2,'y')
# board.show
