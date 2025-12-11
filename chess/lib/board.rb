class Board
  attr_reader :columns, :grid
  def initialize (grid: Array.new(8){Array.new(8){}}, placeholder: ' ')
    @placeholder = placeholder
    @columns = ['a','b','c','d','e','f','g','h']
    @grid = grid
    @kings = []
    @available_moves = {:white => [], :black => []}
    @state = nil
  end

  def chess_notation_to_coordinates(position)
    position_string = position.split('')
    return [position_string[1].to_i-1, @columns.index(position_string[0])]
  end

  def index_to_chess_notation(position)
    return "#{@columns[position[1]]}#{position[0]+1}"
  end

  def do(move_string)
    start_coordinates = chess_notation_to_coordinates(move_string.slice(0,2))
    end_coordinates = chess_notation_to_coordinates(move_string.slice(2,2))
    piece = @grid[start_coordinates[0]][start_coordinates[1]]  
    # end_position = @grid[end_coordinates[0]][end_coordinates[1]]  
   
    if piece.is_a?(Piece)
      move = piece.get_move(end_coordinates) 
      if !move.nil?
        # action = move[:action]
        place(piece, end_coordinates)
        clear(start_coordinates)
        return true 
      else 
        puts "piece can't make that move"
      end
    else 
      puts "Square is empty"
    end

    return false 
  end

=begin
  def place_many(pieces, positions)
    raise TypeError unless pieces.is_a?(Array) && positions.is_a?(Array)
    pieces.each_with_index do |piece, i|
      place(piece, positions[i])
    end
  end
=end

  def place(piece, position)
    position = chess_notation_to_coordinates(position) if position.is_a?(String)
    @grid[position[0]][position[1]] = piece
    piece.current_position = [position[0],position[1]] if piece.is_a?(Piece)
  end

  def clear(position)
    position = chess_notation_to_coordinates(position) if position.is_a?(String)
    @grid[position[0]][position[1]] = nil 
  end

  def update_all_piece_moves()
    @kings =[]
     @grid.each_with_index do |row, index0|
       row.each_with_index do |piece, index1|
            next if !piece.is_a?(Piece) 
            if piece.name == 'king'
              @kings << {piece: piece, current_position: [index0,index1]}
              next 
            end
            moves = piece.update_moves([index0,index1]) 
            # moves.each {|moves| @moves[piece.team] << move }
          end
       end 

=begin 
    @kings.each do |king|
      moves = king.update_moves(king[:current_position]) 
      non_check_moves =  moves.select {|move| @moves[king.other_team].none? { |m| m[:position] == move}} 
      king.set_king_moves(non_check_moves) 
    end 
=end
  end

  def update_game_state() #move to chess and player classes
   black_in_check = @moves[:white].select {|move| move[:action] == :check}
   white_in_check = @moves[:black].select {|move| move[:action] == :check}

   @kings.each do |king| 
      if king.moves.length == 0 
        white_check_mate = true if king.team == :white
        black_check_mate = true if king.team == :black
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