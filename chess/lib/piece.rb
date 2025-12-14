class Piece
  attr_accessor :current_position, :has_moved, :previous_position, :en_passant_capturable
  attr_reader :visual, :moves, :team, :name, :other_team, :DIRECTION
  attr_writer :board

  def initialize (name, team, visual = nil, board = nil)
    @name = name
    @team =  team
    @visual = visual
    @moves = []
    @prev_moves = []
    @has_moved = false
    @current_position = nil 
    @previous_position = nil 
    @board = board
    @en_passant_capturable = false 

    if team == :white
      @PAWN_START_ROW = 1
      @PAWN_PROMOTION_ROW = 7
      @DIRECTION = 1
      @QUEEN_VISUAL = 'Q'
      @other_team == :black 
    else 
      @PAWN_START_ROW = 6
      @PAWN_PROMOTION_ROW = 0
      @DIRECTION = -1 
      @QUEEN_VISUAL = 'q'
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
    # return if !target_square.is_a?(Piece) && type == :capture_only => we need all capturing moves even listed event if the pawn cannot actually make that move for the King to check.
    
    return :hit if target_square.is_a?(Piece) && target_square.team == @team
    if target_square.is_a?(Piece) && target_square.team != @team 
      return if type == :move_only
      action = (target_square.name == 'king' ? :check : :capture)
      @moves << {position: end_coordinates, action: action, type: type}
      return :hit 
    elsif @name == 'pawn' && !target_square.is_a?(Piece) && type == :capture_only
      en_passant_end_coordiantes = [ex+(-@DIRECTION),ey]
      epx,epy = en_passant_end_coordiantes
      en_passant_target_square = @board.grid[epx][epy]
      if en_passant_target_square.is_a?(Piece) && en_passant_target_square.en_passant_capturable
        puts en_passant_target_square
        @board.index_to_chess_notation(end_coordinates)
        @moves << {position: end_coordinates , action: :capture, type: :en_passant}
        p @moves
      end
      return :empty
    else 
      @moves << {position: end_coordinates, action: nil, type: type}
      return :empty 
    end
  end

  def pawn_moves () 
    check_and_append_move([2*@DIRECTION,0], :move_only) if @current_position[0] == @PAWN_START_ROW 
    check_and_append_move([1*@DIRECTION,0], :move_only)
    check_and_append_move([1*@DIRECTION,1], :capture_only)
    check_and_append_move([1*@DIRECTION,-1], :capture_only)
  end

  def rook_moves ()
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
    [[1,-1],[1,0],[1,1],[0,-1],[0,1],[-1,-1],[-1,0],[-1,1]].each {|delta| check_and_append_move(delta)}
  end

  def filter_moves(moves)
    @moves = @moves.select{|move| !moves.include?(move[:position])}
  end

  def update_moves()
    @en_passant_capturable = false
    @prev_moves = @moves
    @moves = []
    return if @current_position.nil?
    send("#{@name.downcase}_moves") 
    return @moves
  end

  def get_move(position)
    move = @moves.select { |move| move[:position] == position }[0]
    move.nil? ? nil : move
  end

  def add_move(end_coordinates, action, type = nil)
    @moves << {position: end_coordinates, action: action, type: type}
  end

  def checked?
   @moves.any? {|move| move[:action] == :check}
  end

  def rollback()
    @moves = @prev_moves
    @prev_moves = []
  end

  def promote() 
    return if (@name != 'pawn' || @current_position[0] != @PAWN_PROMOTION_ROW)
    p "#{@name} + #{@current_position}"
    p "promoting pawn"
    @name = 'queen'
    @visual = @QUEEN_VISUAL
    update_moves()
  end
end