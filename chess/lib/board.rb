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
    from_square = @grid[from_coordinates[0]][from_coordinates[1]]  
    end_square = @grid[end_coordinates[0]][end_coordinates[1]] 

    if from_square.is_a?(Piece) && from_square.team == team
      move = from_square.get_move(end_coordinates) 
      return if move.nil? || (!end_square.is_a?(Piece) && move[:type] == :capture_only)
      @rollback_move[0] = [from_square, from_coordinates]
      @rollback_move[1] = [end_square, end_coordinates]
      clear(from_coordinates)
      place(from_square, end_coordinates)
      return move 
    end
  end

  def place(piece, position, inital_setup = false)
    position = chess_notation_to_coordinates(position) if position.is_a?(String)
    @grid[position[0]][position[1]] = piece
    return if !piece.is_a?(Piece)
    piece.current_position = [position[0],position[1]] 
    piece.has_moved = true if !inital_setup
  end

  def clear(position)
    position = chess_notation_to_coordinates(position) if position.is_a?(String)
    square = @grid[position[0]][position[1]]
    square.current_position = nil if square.is_a?(Piece)
    @grid[position[0]][position[1]]= nil 
  end

  def rollback
    #handle promotion?
    place(@rollback_move[0][0], @rollback_move[0][1])
    place(@rollback_move[1][0], @rollback_move[1][1])
  end

  def can_castle?(player)
    index = player.team == :white ? 0 : 7

    rook_queen_square = @grid[index][0]
    rook_queen_ok = rook_queen_square.is_a?(Piece) && rook_queen_square.name == 'rook' && !rook_queen_square.has_moved

    rook_king_square = @grid[index][7] 
    rook_king_ok = rook_king_square.is_a?(Piece) && rook_king_square.name == 'rook' && !rook_king_square.has_moved

    king = @grid[index][4] 
    king_ok = king.is_a?(Piece) && king.name == 'king' && !king.has_moved

    empty_queen_side = !@grid[index][1].is_a?(Piece) && !@grid[index][2].is_a?(Piece) && !@grid[index][3].is_a?(Piece)
    empty_king_side = !@grid[index][5].is_a?(Piece) && !grid[index][6].is_a?(Piece)

    castle_queen_side = rook_queen_ok && king_ok && empty_queen_side
    caslte_king_side = rook_king_ok && king_ok && empty_king_side
    return [castle_queen_side, caslte_king_side]
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