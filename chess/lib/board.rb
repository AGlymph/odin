class Board
  attr_reader :columns
  def initialize (placeholder: ' ')
    @placeholder = placeholder
    @columns = ['a','b','c','d','e','f','g','h']
    @grid = Array.new(8){Array.new(8){}}
  end

  def chess_notation_to_index(position)
    position_string = position.split('')
    return [position_string[1].to_i-1, @columns.index(position_string[0])]
  end

  def index_to_chess_notation(position)
    return "#{@columns[position[1]]}#{position[0]+1}"
  end

  def place_many(pieces, positions)
    raise TypeError unless pieces.is_a?(Array) && positions.is_a?(Array)
    pieces.each_with_index do |piece, i|
      place(piece, positions[i])
    end
  end

  def place(piece, position)
    position = chess_notation_to_index(position) if position.is_a?(String)
    @grid[position[0]][position[1]] = piece
  end

  def clear(position)
    position = chess_notation_to_index(position) if position.is_a?(String)
    @grid[position[0]][position[1]] = nil 
  end

  def update_all_piece_moves()
     @grid.each_with_index do |row, index0|
       row.each_with_index do |piece, index1|
          piece.update_moves([index0,index1], @grid) if piece.is_a?(Piece)
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