# movement vector or movement rules module that is read on initilization and saved to the pice. At init get block of movement rules? A piece has a movement vector 
class Piece
  attr_accessor :current_position
  attr_reader :visual, :moves
  attr_writer :board

  def initialize (name, team, visual = nil, board = nil)
    @name = name
    @team =  team
    @visual = visual
    @moves = []
    @current_position = nil 
    @board = board
    @pawn_start_row = team == :white ? 1 : 6
  end

  def in_bounds?(position)
    position.all? { |coord| coord.between?(0,7)}
  end

  def pawn_moves ()
    moves = []
    x,y = @current_position    
    p @current_position
    target = [x+2,y]
    tx,ty = target
    TODO HANDLE DIRECTION OF GOING DOWN VS UP. 
    moves << {position: target, action: nil} if in_bounds?(target) && x == @pawn_start_row && @board.grid[tx][ty].nil?
    p moves
    target = [x+1,y]
    tx,ty = target
    moves << {position: target, action: nil} if in_bounds?(target) && @board.grid[tx][ty].nil?

    target = [x+1,y+1]
    tx,ty = target
    moves << {position: target, action: :capture} if in_bounds?(target) && @board.grid[tx][ty].is_a?(Piece)

    target = [x+1,y-1]
    tx,ty = target
    moves << {position: target, action: :capture} if in_bounds?(target) && @board.grid[tx][ty].is_a?(Piece)
  
    p moves
    return moves
  end

  def rook_moves ()
    []
  end

  def knight_moves ()
      moves = []
      x,y = @current_position
      movement_deltas =  [[2,1],[1,2],[-1,2],[-2,1],[-2,-1],[-1,-2],[1,-2],[2,-1]]
      target_pos  = movement_deltas.filter_map {|dx, dy| 
        new_pos = [x + dx, y + dy]
        new_pos if in_bounds?(new_pos)
      }
      target_pos.each do |pos|
        x,y = pos
        move = {position: pos}
        square = @board.grid[x][y]
        if square.is_a?(Piece)
          move[:action] = :capture
        else
          move[:action] = nil
        end
        moves << move
      end
      return moves
  end

  def bishop_moves ()
    []
  end

  def queen_moves ()
    []
  end

  def king_moves ()
    []
  end

  def update_moves(current_position)
    @current_position = current_position
    @moves = send("#{@name.downcase}_moves") 
  end

  def can_move?(position)
    @moves.any? { |move|  move[:position] == position }
  end
end