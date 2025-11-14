class Board
  def initialize (starting_positions: "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR", placeholder: ' ')
    @placeholder = placeholder
    @columns = ['A','B','C','D','E','F','G','H']
    @board = update_whole_board(starting_positions)
  end

  def update_whole_board(fen_string)
    board = @columns.to_h {|c| [c , Array.new(8)]}
    # board = Array.new(8){Array.new(8) {@placeholder}} # switch to a dict
    p board
    return board
  end

  def update_with_move
    
  end
  
 

  def get_at_position
    
  end

  def show
    puts "  ---------------------------------"
    (@board.size - 1).downto(0) do |index|
      puts "#{index + 1} | #{@board[index].join(' | ')} |"
      puts "  ---------------------------------"
    end
    puts "    A | B | C | D | E | F | G | H"
  end
end

b = Board.new()
b.show
b.show