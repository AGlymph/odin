class Board
  attr_reader :columns, :grid
  def initialize (grid: Array.new(8){Array.new(8){}}, placeholder: ' ')
    @placeholder = placeholder
    @columns = ['a','b','c','d','e','f','g','h']
    @grid = grid
    @rollback_move = []
  end

  def chess_notation_to_coordinates(position)
    position_string = position.split('')
    return [position_string[1].to_i-1, @columns.index(position_string[0])]
  end

=begin 
  def index_to_chess_notation(position)
    return "#{@columns[position[1]]}#{position[0]+1}"
  end
=end 

  def do(move_string, team)
    from_coordinates = chess_notation_to_coordinates(move_string.slice(0,2))
    end_coordinates = chess_notation_to_coordinates(move_string.slice(2,2))
    move_piece = @grid[from_coordinates[0]][from_coordinates[1]]  
    end_position = @grid[end_coordinates[0]][end_coordinates[1]]  
 
    if move_piece.is_a?(Piece)
      return false if move_piece.team != team
      move = move_piece.get_move(end_coordinates) 
      if !move.nil?
        return false if !end_position.is_a?(Piece) && move[:type] == :capture_only 
        @rollback_move[0] = [move_piece, from_coordinates]
        @rollback_move[1] = [end_position, end_coordinates]
        place(move_piece, end_coordinates)
        clear(from_coordinates)
        return true 
      else 
        puts "piece can't make that move"
      end
    else 
      puts "Square is empty"
    end

    return false 
  end

  def place(piece, position)
    position = chess_notation_to_coordinates(position) if position.is_a?(String)
    @grid[position[0]][position[1]] = piece
    piece.current_position = [position[0],position[1]] if piece.is_a?(Piece)
  end

  def clear(position)
    position = chess_notation_to_coordinates(position) if position.is_a?(String)
    @grid[position[0]][position[1]] = nil 
  end

  def rollback
    #handle promotion?
    place(@rollback_move[0][0], @rollback_move[0][1])
    place(@rollback_move[1][0], @rollback_move[1][1])
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