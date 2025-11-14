require_relative 'board'

class Chess
  def initialize (board: Board.new())
    @board = :board 
    
  end

  def get_turn 
    
  end

  def play
    puts "//LET'S PLAY CHESS!//"
    @board.show
    loop do
      do_turn(@players[0])
      @board.show
      break if game_over?
      do_turn(@players[1])
      @board.show
      break if game_over?
    end
    show_result
  end
end

# each round a play will input a chess move using chess notation
# the computer wil check if that is a valid move for that move to make 

# the Game will create every valid next move for each piece
# when the player inputs a move, the Game will check the valid moves for this move 
# if it is valid, the game will accept the move and progress the game 
# if it is not valid, 
# 
# Only after a piece is moved/updated -- or the game starts -- does the game check for the valid moves
#
# The game will save to FEN and load from FEN 
# 


# ex: pawn < piece 
# current position (to make double available)
# target position --> not stored, but needed to evaluate 
# enemy piece in target position  --> not stored, but needed to evaluate 
# movement vectors 
# status\state? 

# special case:
# # rook and bishop cannot go past a blocking piece. (can't jump)
# # pawn to queen promotion
# # king castling (many )
# 

# get input 
# pass to target piece (the one the player is trying to move), ask if it is moveable 
# if moveable perform the action 
