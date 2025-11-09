class Chess
  def initialize
    
  end

  def get_turn 
    
  end

  def play
    
  end
end

# each round a play will input a chess cooridnate
# the game will check if 
# # is it a valid cooridante 
# # is it a valid move to make 
# if valid then make the move
# if not valid then get another guess until it is valid 

# Touch Piece: (the player inputs the piece and must move that piece, they cannot)


# ex: pawn < piece 
# current position (to make double available)
# target position --> not stored, but needed to evaluate 
# enemy piece in target position  --> not stored, but needed to evaluate 
# movement vectors 
# status\state? 
# each piece is a current_position, state, and movement_vectors, ??can_jump, 
# 

# special case:
# # rook and bishop cannot go past a blocking piece. (can't jump)
# # pawn to queen promotion
# # king castling (many )
# 

# get input 
# pass to target piece (the one the player is trying to move), ask if it is moveable 
# if moveable perform the action 
