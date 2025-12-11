class Piece
  attr_accessor :current_position
  attr_reader :visual, :moves, :team, :name, :other_team
  attr_writer :board

  def initialize (name, team, visual = nil, board = nil)
    @name = name
    @team =  team
    @visual = visual
    @moves = []
    @prev_moves = []
    @current_position = nil 
    @board = board

    if team == :white
      @PAWN_START_ROW = 1
      @PAWN_PROMOTION_ROW = 6
      @DIRECTION = 1
      @other_team == :black 
    else 
      @PAWN_START_ROW = 6
      @PAWN_PROMOTION_ROW = 1
      @DIRECTION = -1 
      @other_team == :white
    end
  end

  def in_bounds?(position)
    position.all? { |coord| coord.between?(0,7)}
  end

  def check_and_append_move (delta, type = nil)
    x,y = @current_position     
    end_coordinates =  [x + delta[0], y + delta[1]]
    return if !in_bounds?(end_coordinates)

    ex,ey = end_coordinates
    target_square = @board.grid[ex][ey]
    return if target_square.is_a?(Piece) && type == :move_only
    # return if !target_square.is_a?(Piece) && type == :capture_only => we need all capturing moves even listed event if the pawn cannot actually make that move for the King to check. 

    if @name == 'pawn' && ex == @PAWN_PROMOTION_ROW 
      action = :promotion 
    elsif !target_square.is_a?(Piece) 
      action = nil 
    elsif target_square.name == 'king' && target_square.team != @team #TODO Apply to capture and promotions
      action = :check 
    else 
      action = :capture
    end

    @moves << {position: end_coordinates, action: action, type: type}

    return (target_square.is_a?(Piece) ? :hit : :empty)
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

  def filter_moves(moves)
    @moves = @moves.select{|move| !moves.include?(move[:position])}
  end

  def update_moves()
    @prev_moves = @moves
    @moves = []
    send("#{@name.downcase}_moves") 
    return @moves
  end

  def get_move(position)
    move = @moves.select { |move| move[:position] == position }[0]
    move.nil? ? nil : move
  end

  def checked?
   @moves.any? {|move| move[:action] == :check}
  end

  def rollback()
    @moves = @prev_moves
    @prev_moves = []
  end
end