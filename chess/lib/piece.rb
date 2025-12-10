# movement vector or movement rules module that is read on initilization and saved to the pice. At init get block of movement rules? A piece has a movement vector 
class Piece
  attr_accessor :current_position
  attr_reader :visual, :moves, :team, :name
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
      @PAWN_PROMOTION_ROW = 6
      @DIRECTION = 1
    else 
      @PAWN_START_ROW = 6
      @PAWN_PROMOTION_ROW = 1
      @DIRECTION = -1 
    end
  end

  def in_bounds?(position)
    position.all? { |coord| coord.between?(0,7)}
  end

  def check_and_append_move (delta, type = :all)
    x,y = @current_position     
    end_coordinates =  [x + delta[0], y + delta[1]]

    return if !in_bounds?(end_coordinates)
    ex,ey = end_coordinates
    target_square = @board.grid[ex][ey]

    if target_square.is_a?(Piece) 
      return if target_square.team == @team
      return if type == :move_only
      @moves << (target_square.name == 'king' ? {position: end_coordinates, action: :check} : {position: end_coordinates, action: :capture})
      return :hit
    else
      return if type == :capture_only
      @moves << (@name == 'pawn' && x = @PAWN_PROMOTION_ROW ? {position: end_coordinates, action: :promotion}  : {position: end_coordinates, action: nil})
      return :empty
    end
  end

  def pawn_moves () 
    #ADD PROMOTION
    check_and_append_move([2*@DIRECTION,0], :move_only) if @current_position[0] == @PAWN_START_ROW 
    check_and_append_move([1*@DIRECTION,0], :move_only)
    check_and_append_move([1*@DIRECTION,1], :capture_only)
    check_and_append_move([1*@DIRECTION,-1], :capture_only)
  end

  def rook_moves ()
    #ADD CASTLING?
    (1..7).each do |i| #up 
      move = check_and_append_move([i,0])
      break if move.nil? || move == :hit
    end
    (1..7).each do |i| #down
      move = check_and_append_move([-i,0])
      break if move.nil? || move == :hit
    end
    (1..7).each do |i| #right
       move = check_and_append_move([0,+i])
      break if move.nil? || move == :hit
    end
    (1..7).each do |i| #left
      move = check_and_append_move([0,-i])
      break if move.nil? || move == :hit
    end
  end

  def knight_moves ()
      [[2,1],[1,2],[-1,2],[-2,1],[-2,-1],[-1,-2],[1,-2],[2,-1]].each {|delta| check_and_append_move(delta)}
  end

  def bishop_moves ()
    (1..7).each do |i| #up&right
      move = check_and_append_move([i,i])
      break if move.nil? || move == :hit
    end
    (1..7).each do |i| #up&left
      move = check_and_append_move([i,-i])
      break if move.nil? || move == :hit
    end
    (1..7).each do |i| #down&right
      move = check_and_append_move([-i,i])
      break if move.nil? || move == :hit
    end
    (1..7).each do |i| #down&left
      move = check_and_append_move([-i,-i])
      break if move.nil? || move == :hit
    end
  end

  def queen_moves ()
    rook_moves()
    bishop_moves()
  end

  def king_moves ()
    #castling?
    #when in check
    [[1,-1],[1,0],[1,1],[0,-1],[0,1],[-1,-1],[-1,0],[-1,1]].each {|delta| check_and_append_move(delta)}
  end

  def update_moves(current_position)
    @current_position = current_position
    @moves = []
    send("#{@name.downcase}_moves") 
    @moves.compact!
  end

  def get_move(position)
    move = @moves.select { |move| move[:position] == position }
    move.empty? ? nil : move[0]
  end
end