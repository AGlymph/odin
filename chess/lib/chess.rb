require_relative 'board'
require_relative 'piece'
require_relative 'player'


class Chess
  PIECE_NAMES = {'r' => 'rook', 'n' => 'knight','b' =>'bishop','q'=>'queen','k'=>'king','p'=> 'pawn'}
  def initialize ()
    @board = nil
    @players = {white: [], black: []}
    @current_turn = :white
    load_fen()
    @board.update_all_piece_moves

  end

  def load_fen(fen_string = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR b KQkqOTHERINFO")
    fen_arr= fen_string.split(' ')
    row_arr = fen_arr[0].split('/').reverse
    @current_turn = fen_arr[1] == 'w' ? :white : :black
    @board = Board.new()
    board_grid = []
    row_arr.each do |r|
      row = []
      r.each_char do |c|
        if /[rnbqkbnrp]/.match?(c)
          color = :black
          name = PIECE_NAMES[c]
          piece = Piece.new(name, color, c, @board)
          @players[color] << piece
          row << piece
        elsif /[RNBQKBNRP]/.match?(c)
          color = :white
          name = PIECE_NAMES[c.downcase]
          piece = Piece.new(name, color, c, @board)
          @players[color] << piece
          row << piece
        elsif /[0-9]/.match?(c)
          c.to_i.times do 
            row << []
          end
        else 
          p c
        end
      end
      board_grid << row
    end
    @board.set_grid_to(board_grid)
  end

  def do_turn(player)
    move = nil 
    loop do 
      puts "Enter two squares: ex: a1b3"
      move = gets.chomp.gsub(' ', '').slice(0,4).downcase
      valid_input = /^[a-h][1-9][a-h][1-9]$/.match?(move) 
      succesful_move =  @board.do(move) if valid_input 
      break if succesful_move
    end
  end

  def play
    puts "//LET'S PLAY CHESS!//"
    @board.show
    loop do 
       do_turn(@players[@current_turn])
       @board.show
       # break if game_over?
       @board.update_all_piece_moves
       @current_turn = @current_turn == :white ? :black : :white
       break
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