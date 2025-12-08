# movement vector or movement rules module that is read on initilization and saved to the pice. At init get block of movement rules? A piece has a movement vector 
class Piece
  attr_reader :visual, :moves
  def initialize (name, team, visual = nil)
    @name = name
    @team =  team
    @visual = name
    @movement_vectors =  [[2,1],[1,2],[-1,2],[-2,1],[-2,-1],[-1,-2],[1,-2],[2,-1]]
    @moves = nil
  end

  def update_moves(current_position, grid)
     moves = []
     @movement_vectors.each do |vector|
      move_position = [current_position[0] + vector[0], current_position[1] + vector[1]]
      moves << move_position if move_position[0].between?(0,7) && move_position[1].between?(0,7)
    end
     @moves = moves
  end

  def can_move?(position)
    @movement_vectors.include?
  end
end