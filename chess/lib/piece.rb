# movement vector or movement rules module that is read on initilization and saved to the pice. At init get block of movement rules? A piece has a movement vector 
class Piece
  attr_accessor :current_position
  attr_reader :visual, :moves, :team
  attr_writer :board

  def initialize (name, team, visual = nil, board = nil)
    @name = name
    @team =  team
    @visual = visual
    @moves = []
    @current_position = nil 
    @board = board

    if name == 'rook' || name == 'king'
      @kingside_castle = true
      @queenside_castle = true
    end

    if team == :white
      @PAWN_START_ROW = 1
      @DIRECTION = 1
    else 
      @PAWN_START_ROW = 6
      @DIRECTION = -1 
    end
  end

  def in_bounds?(position)
    position.all? { |coord| coord.between?(0,7)}
  end

  def pawn_moves ()
    moves = []
    x,y = @current_position    
    #ADD PROMOTION
    target = [x+(2*@DIRECTION),y]
    tx,ty = target
    moves << {position: target, action: nil} if x == @PAWN_START_ROW && !@board.grid[tx][ty].is_a?(Piece)
    target = [x+1*@DIRECTION,y]
    tx,ty = target
    moves << {position: target, action: nil} if in_bounds?(target) && !@board.grid[tx][ty].is_a?(Piece)

    target = [x+1*@DIRECTION,y+1]
    tx,ty = target
    moves << {position: target, action: :capture} if in_bounds?(target) && @board.grid[tx][ty].is_a?(Piece) && @board.grid[tx][ty].team != @team

    target = [x+1*@DIRECTION,y-1]
    tx,ty = target
    moves << {position: target, action: :capture} if in_bounds?(target) && @board.grid[tx][ty].is_a?(Piece) && @board.grid[tx][ty].team != @team
    return moves
  end

  def rook_moves ()
    moves = []
    x,y = @current_position
    #castling goes here
    
    up = 7 - x
    down = x
    right = 7 - y
    left = y 

    (1..up).each do |i|
      target = [x+i,y]
      tx,ty = target
      if in_bounds?(target)
        if !@board.grid[tx][ty].is_a?(Piece)
          moves << {position: target, action: nil}
        elsif @board.grid[tx][ty].is_a?(Piece) && @board.grid[tx][ty].team != @team
          moves << {position: target, action: :capture}
          break
        else
          break 
        end
      end
    end

    (1..down).each do |i|
      target = [x-i,y]
      tx,ty = target
      if in_bounds?(target)
        if !@board.grid[tx][ty].is_a?(Piece)
          moves << {position: target, action: nil}
        elsif @board.grid[tx][ty].is_a?(Piece) && @board.grid[tx][ty].team != @team
          moves << {position: target, action: :capture}
          break
        else
          break 
        end
      end
    end

    (1..right).each do |i|
      target = [x,y+i]
      tx,ty = target
      if in_bounds?(target)
        if !@board.grid[tx][ty].is_a?(Piece)
          moves << {position: target, action: nil}
        elsif @board.grid[tx][ty].is_a?(Piece) && @board.grid[tx][ty].team != @team
          moves << {position: target, action: :capture}
          break
        else
          break 
        end
      end
    end

    (1..left).each do |i|
      target = [x,y-i]
      tx,ty = target
      if in_bounds?(target)
        if !@board.grid[tx][ty].is_a?(Piece)
          moves << {position: target, action: nil}
        elsif @board.grid[tx][ty].is_a?(Piece) && @board.grid[tx][ty].team != @team
          moves << {position: target, action: :capture}
          break
        else
          break 
        end
      end
    end

    return moves
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

  def get_move(position)
    move = @moves.select { |move| move[:position] == position }
    move.empty? ? nil : move[0]
  end
end