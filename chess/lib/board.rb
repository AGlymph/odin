class Board
  attr_reader :columns, :grid
  def initialize (grid: Array.new(8){Array.new(8){}}, placeholder: ' ')
    @placeholder = placeholder
    @columns = ['a','b','c','d','e','f','g','h']
    @grid = grid
  end

  def set_grid_to(array)
    @grid = array
  end

  def chess_notation_to_coordinates(position)
    position_string = position.split('')
    return [position_string[1].to_i-1, @columns.index(position_string[0])]
  end

  def index_to_chess_notation(position)
    return "#{@columns[position[1]]}#{position[0]+1}"
  end

  def do(move_string)
    # TO DO CASTLING
    start_position_coordinates = chess_notation_to_coordinates(move_string.slice(0,2))
    end_position_coordinates = chess_notation_to_coordinates(move_string.slice(2,2))
    start_position = @grid[start_position_coordinates[0]][start_position_coordinates[1]]  
    end_position = @grid[end_position_coordinates[0]][end_position_coordinates[1]]  
    if start_position.is_a?(Piece)
       piece = start_position
       if piece.can_move?(end_position_coordinates)
         puts "doing move"
         place(piece, end_position_coordinates)
         clear(start_position_coordinates)
         if end_position.is_a?(Piece)
           puts "captured! TO DO capturing stuff"
         end
         return true
       else
         puts "piece can't make that move"
       end
    else 
      puts "Square is empty"
    end
    return false 
  end


  def place_many(pieces, positions)
    raise TypeError unless pieces.is_a?(Array) && positions.is_a?(Array)
    pieces.each_with_index do |piece, i|
      place(piece, positions[i])
    end
  end

  def place(piece, position)
    position = chess_notation_to_coordinates(position) if position.is_a?(String)
    @grid[position[0]][position[1]] = piece
  end

  def clear(position)
    position = chess_notation_to_coordinates(position) if position.is_a?(String)
    @grid[position[0]][position[1]] = nil 
  end

  def update_all_piece_moves()
     @grid.each_with_index do |row, index0|
       row.each_with_index do |piece, index1|
          piece.update_moves([index0,index1]) if piece.is_a?(Piece)
       end 
     end
  end

  def get_row_string(index)
      @grid[index].reduce('') {|row_string, piece| row_string << (piece.is_a?(Piece) ? piece.visual : @placeholder) << ' | ' }
  end

  def show
    puts "  ---------------------------------"
    (@columns.size - 1).downto(0) do |index|
      puts "#{index + 1} | #{get_row_string(index)}"
      puts "  ---------------------------------"
    end
    puts "    #{@columns.join(' | ')}"
  end
end