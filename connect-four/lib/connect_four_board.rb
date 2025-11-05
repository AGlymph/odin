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
    flipped_grid = @grid.map {|col| col.reverse} # indexes are opposite of a how a connect four board is viewed. 
    col_index = position[0] - 1
    row_index = position[1] - 1
    column = flipped_grid[col_index] 
    column_string = column.join
    row = flipped_grid.transpose[row_index]
    row_string = row.join

    max_column_index = @grid.length - 1
    max_row_index = @grid[0].length - 1 

    left_right_position_deltas = [[-3,-3],[-2,-2],[-1,-1],[0,0],[1,1],[2,2],[3,3]]
    left_right_diagonal_string = ""
    left_right_position_deltas.each do |delta|
      diagonal_col_index = col_index + delta[0]
      diagonal_row_index  = row_index + delta[1]
      left_right_diagonal_string += flipped_grid[diagonal_col_index][diagonal_row_index] if diagonal_col_index.between?(0, max_column_index) && diagonal_row_index.between?(0, max_row_index)
    end

    right_left_poistion_deltas = [[-3,3],[-2,2],[-1,1],[0,0],[1,-1],[2,-2],[3,-3]]
    right_left_diagonal_string = ""
    right_left_poistion_deltas.each do |delta|
      diagonal_col_index = col_index + delta[0]
      diagonal_row_index  = row_index + delta[1]
      right_left_diagonal_string += flipped_grid[diagonal_col_index][diagonal_row_index] if diagonal_col_index.between?(0, max_column_index) && diagonal_row_index.between?(0, max_row_index)
    end

    4.downto(1) do |n|
      check_chain = piece*n
      return n if (column_string.include?(check_chain) || row_string.include?(check_chain) || left_right_diagonal_string.include?(check_chain) || right_left_diagonal_string.include?(check_chain))
    end
    return 0
  end
end
