class Board
  attr_reader :columns, :grid, :en_passant_postion
  def initialize (grid: Array.new(8){Array.new(8){}}, placeholder: ' ')
    @placeholder = placeholder
    @columns = ['a','b','c','d','e','f','g','h']
    @grid = grid
    @rollback_move = []
    @en_passant_postion = nil
  end

  def chess_notation_to_coordinates(position)
    position_string = position.split('')
    return [position_string[1].to_i-1, @columns.index(position_string[0])]
  end

  def index_to_chess_notation(position)
    return "#{@columns[position[1]]}#{position[0]+1}"
  end

  def do(move_string, team)
    from_coordinates = chess_notation_to_coordinates(move_string.slice(0,2))
    end_coordinates = chess_notation_to_coordinates(move_string.slice(2,2))
    from_square = @grid[from_coordinates[0]][from_coordinates[1]]  
    end_square = @grid[end_coordinates[0]][end_coordinates[1]] 

    if from_square.is_a?(Piece) && from_square.team == team
      move = from_square.get_move(end_coordinates) 
      return if move.nil? || (!end_square.is_a?(Piece) && move[:type] == :capture_only)

      if move[:type] == :en_passant 
        target_end_coordinates = [end_coordinates[0]+(-from_square.DIRECTION), end_coordinates[1]]
        target_end_square = @grid[target_end_coordinates[0]][target_end_coordinates[1]]
        @rollback_move[0] = [from_square, from_coordinates]
        @rollback_move[1] = [target_end_square, target_end_coordinates]
        clear(from_coordinates)
        clear(target_end_coordinates)
        place(from_square, end_coordinates)
        show()

      else 
        @rollback_move[0] = [from_square, from_coordinates]
        @rollback_move[1] = [end_square, end_coordinates]
        if move[:action] == :castle
          p "castling"
          place(from_square, end_coordinates)
          place(end_square, from_coordinates)
        else
          clear(from_coordinates)
          place(from_square, end_coordinates)
        end
      end

     
      
      return move 
    end
  end

  def place(piece, position, inital_setup = false)
    position = chess_notation_to_coordinates(position) if position.is_a?(String)
    @grid[position[0]][position[1]] = piece
    return if !piece.is_a?(Piece)
    xdelta = (position[0] - piece.previous_position[0]).abs if piece.previous_position
    piece.current_position = [position[0],position[1]] 
    piece.has_moved = true if !inital_setup

    if xdelta == 2 && piece.name =='pawn'
      piece.en_passant_capturable 
      offset = position[0] == 3 ? 1 : -1 
      @en_passant_position = index_to_chess_notation([position[0]-offset,position[1]])
    else 
      @en_passant_position = nil
    end 
  end

  def clear(position)
    position = chess_notation_to_coordinates(position) if position.is_a?(String)
    square = @grid[position[0]][position[1]]
    if square.is_a?(Piece)
      square.previous_position = square.current_position
      square.current_position = nil
    end
    @grid[position[0]][position[1]]= nil 
  end

  def rollback
    place(@rollback_move[0][0], @rollback_move[0][1])
    place(@rollback_move[1][0], @rollback_move[1][1])
  end

  def set_en_passant_true_for_piece_at(string)
     position = chess_notation_to_coordinates(string) if string.is_a?(String)
     offset = position[0] == 2 ? 1 : -1 
     square = @grid[position[0]+offset][position[1]]
     if square.is_a?(Piece)
      square.en_passant_capturable = true 
      @en_passant_position = string 
     end
  end

  def set_castle_moves(player)
    index = player.team == :white ? 0 : 7
    king = @grid[index][4] 
    king_ok = king.is_a?(Piece) && king.name == 'king' && !king.has_moved

    if player.can_castle_queen_side
      rook_queen_square = @grid[index][0]
      rook_queen_ok = rook_queen_square.is_a?(Piece) && rook_queen_square.name == 'rook' && !rook_queen_square.has_moved
      empty_queen_side = !@grid[index][1].is_a?(Piece) && !@grid[index][2].is_a?(Piece) && !@grid[index][3].is_a?(Piece)

      if rook_queen_ok && king_ok && empty_queen_side
        rook_queen_square.add_move([index,4], :castle)
        king.add_move([index,0], :castle)
      elsif !rook_queen_ok || !king_ok 
        player.can_castle_queen_side = false
      end   
    end

    if player.can_castle_king_side
      rook_king_square = @grid[index][7] 
      rook_king_ok = rook_king_square.is_a?(Piece) && rook_king_square.name == 'rook' && !rook_king_square.has_moved
      empty_king_side = !@grid[index][5].is_a?(Piece) && !grid[index][6].is_a?(Piece)

      if rook_king_ok && king_ok && empty_king_side
        rook_king_square.add_move([index,4],:castle)
        king.add_move([index,7], :castle)
      elsif !rook_king_ok || !king_ok
        player.can_castle_king_side = false
      end
    end
  end

  def get_row_string(index)
    @grid[index].reduce('') {|row_string, piece| row_string << (piece.is_a?(Piece) ? piece.visual : @placeholder) << ' | ' }
  end

  def get_board_string_for_fen()
    board_string = ''
    7.downto(0) do |i|
      current_count = 0
      @grid[i].each do |square|
        if square.is_a?(Piece) 
          board_string << current_count.to_s if current_count > 0
          board_string << square.visual 
          current_count = 0
        else 
          current_count = current_count + 1
        end
      end 
      board_string << current_count.to_s if current_count > 0
      board_string << '/' if i != 0
    end 
    return board_string 
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