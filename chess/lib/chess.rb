require_relative 'board'
require_relative 'piece'
require_relative 'player'

#TDODO CASTLING, PROMOTION, CHECK STATE, CHECK MATE STATE, SAVING/exit early/, list help
class Chess
  PIECE_NAMES = {'r' => 'rook', 'n' => 'knight','b' =>'bishop','q'=>'queen','k'=>'king','p'=> 'pawn'}
  def initialize ()
    @board = nil
    @players = {white: Player.new(:white), black: Player.new(:black)}
    @current_team = :white
    @checked = false
    setup_game("1k6/8/2P5/3K3R/8/8/8/8 b")
    update_all_moves()
  end

  def update_all_moves()
    @players[:white].update_moves()
    @players[:black].update_moves()
    @players[:white].update_king_moves(@players[:black].check_positions)
    @players[:black].update_king_moves(@players[:white].check_positions)
  end

  def spawn_piece(piece_symbol, team)
    name = PIECE_NAMES[piece_symbol.downcase]
    piece = Piece.new(name, team, piece_symbol, @board)
    @players[team].pieces << piece
    @players[team].king = piece if name == 'king'
    return piece 
  end

  def setup_game(fen_string = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR b KQkqOTHERINFO")
    fen_arr= fen_string.split(' ')
    row_arr = fen_arr[0].split('/').reverse
    @current_turn = fen_arr[1] == 'w' ? :white : :black
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
        @board.place(piece, [coordx,coordy])
      end
    end
  end

  def do_turn(player)
    move = nil 
    loop do 
      puts "Enter two squares: ex: a1b3"
      move = gets.chomp.gsub(' ', '').slice(0,4).downcase
      # save, exit, help, or move 
      valid_input = /^[a-h][1-9][a-h][1-9]$/.match?(move) 
      succesful_move =  @board.do(move, player.team) if valid_input 
      break if succesful_move
    end
  end

  def rollback()
    @players[:white].rollback
    @players[:black].rollback
    @board.rollback
  end


  def play
    puts "//LET'S PLAY CHESS!//"
    @board.show
    loop do 
       p @current_team
       player = @players[@current_team]
       p @opponent_team
       opponent =  @players[@opponent_team]
       do_turn(player)
       @board.show
       # break if game_over?
       update_all_moves()

        p "checking #{@opponent_team}"
       if @checked && opponent.checked_oponent?
        p "rollback"
        rollback()
        @board.show
        next 
        # rollback one turn keep turn the player the same and do the loop again
       end
       @board.show
       
       p "checking #{@current_team}"
       @checked = player.checked_oponent?



       # @board.update_all_piece_moves
       # update players
       # update states 
       @current_team, @opponent_team = (@current_team == :white ? [:black, :white] : [:white, :black])
    end
    #show_result
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