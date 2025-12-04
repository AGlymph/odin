require_relative 'board'
require_relative 'piece'
require_relative 'player'


class Chess
  def initialize (board: Board.new())
    @board = board
    @players =  [Player.new(:white), Player.new(:black)]  
    @players.each do |player| 
       starting_positions = @board.columns.map {|c| c + player.starting_row} 
       starting_positions.push(*@board.columns.map {|c| c + player.starting_row.next})
       @board.place_many(player.pieces, starting_positions)
    end 
    @board.update_all_piece_moves
  end

  def get_turn 
    
  end

  def play
    # puts "//LET'S PLAY CHESS!//"
    @board.show
    # loop do
     # do_turn(@players[0])
      # @board.show
      # break if game_over?
      # do_turn(@players[1])
      # @board.show
      # break if game_over?
    # end
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