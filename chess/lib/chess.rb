require_relative 'board'
require_relative 'piece'
require_relative 'player'

#TDODO SAVING/exit early/, load from fen, load or new
class Chess
  PIECE_NAMES = {'r' => 'rook', 'n' => 'knight','b' =>'bishop','q'=>'queen','k'=>'king','p'=> 'pawn'}
  def initialize ()
    @board = nil
    @players = {white: Player.new(:white), black: Player.new(:black)}
    @current_team = :white
    @opponent_team = :black
    @check = false
    @mate = false 
    setup_game("r3k2r/1P7/8/8/8/8/PPP1PPPP/R3K2R b Qq")
    update_all_moves()
  end

  def update_all_moves()
    @players[:white].update_moves()
    @players[:black].update_moves()
    @players[:white].update_king_moves(@players[:black].check_positions)
    @players[:black].update_king_moves(@players[:white].check_positions)
    @board.set_castle_moves(@players[:white])
    @board.set_castle_moves(@players[:black])
  end

  def spawn_piece(piece_symbol, team, has_moved_cannot_castle = false)
    name = PIECE_NAMES[piece_symbol.downcase]
    piece = Piece.new(name, team, piece_symbol, @board)
    @players[team].pieces << piece
    @players[team].king = piece if name == 'king'

    return piece 
  end

  def setup_game(fen_string = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq")
    fen_arr= fen_string.split(' ')
    row_arr = fen_arr[0].split('/').reverse
    @current_team, @opponent_team = (fen_arr[1] == 'w' ? [:white, :black] : [:black, :white])
    castling = fen_arr[2]
    castling.each_char do |c|
      case c 
        when 'K'
          @players[:white].can_castle_king_side = true
        when 'Q'
          @players[:white].can_castle_queen_side = true
        when 'k'
          @players[:black].can_castle_king_side = true
        when 'q'
          @players[:black].can_castle_queen_side = true
      end
    end
    
    @board = Board.new()
    board_grid = []
    row_arr.each do |r|
      row = []
      r.each_char do |c|
        if /[rnbqkbnrp]/.match?(c)
          row << spawn_piece(c, :black)
        elsif /[RNBQKBNRP]/.match?(c)
          row << spawn_piece(c, :white)
        elsif /[0-9]/.match?(c)
          c.to_i.times do 
            row << []
          end
        else 
          p "error #{c}"
        end
      end
      board_grid << row
    end

    board_grid.each_with_index do |row, coordx|
      row.each_with_index do |piece, coordy|
        @board.place(piece, [coordx,coordy], true)
      end
    end
  end

  def do_turn(player)
    input = nil 
    loop do 
      puts "Enter your move:"
      input = gets.chomp.gsub(' ', '').slice(0,4).downcase
      if input == 'save'
        return 
      elsif input == 'exit'
        puts 'saving and exiting'
        return  
      elsif input == 'help'
        puts "type two squares to move: 'a1c3'"
        puts "type 'exit' to save and exit" 
      elsif /^[a-h][1-9][a-h][1-9]$/.match?(input) 
         move = @board.do(input, player.team)
         return if !move.nil?
      else
        puts "Don't understand that..."
      end
    end
  end


  def play
    puts "//LET'S PLAY CHESS!//"
    @board.show
    loop do 
       p @current_team
       player = @players[@current_team]
       opponent =  @players[@opponent_team]
       do_turn(player)
       update_all_moves()

       if @check && opponent.checked_oponent?
        rollback()
        next 
       end

       player.promote_pieces
       @board.show
       @check = player.checked_oponent?
       @mate = opponent.can_king_move? 
       if @check && @mate
         puts "CHECK MATE! #{@current_team} won!"
         break 
       end
       
       @current_team, @opponent_team = (@current_team == :white ? [:black, :white] : [:white, :black])
    end
  end
end

game = Chess.new()
game.play


# game begins 
# ask player to load or start new 
# Game will create two players
# Game will create a set of pieces for each player
# Game will put the pieces on the board
# Game will generate all possible next moves for the pieces (one list of all moves per player or should the pieces hold them?)

# if load 
# Game will get the save PGN file
# Game will go through the PGN moves and update each piece 
# Game will update the player turn and counter
# Game will update the list of possible moves 

# If new do nothing

# Wait for player to make move 
# Game will get player input
# Game will verify the player input is in the correct formate
# Game will verify the move is a possible move to make 
# Game will make the move 
# Game will update all pieces possible move list 
# Check win and game over conditons 
# Move to next player

# allow player to save and exit