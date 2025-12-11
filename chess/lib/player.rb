class Player
  attr_accessor :pieces
  attr_reader :team
  attr_writer :king

  def initialize (team)
    @team = team 
    @pieces = []
    @king = nil
  end

  def moves() 
    @pieces.reduce([]) {|moves, piece| moves.concat(piece.moves)}.uniq
  end

  def check_positions() 
    # get the positions where a King could be checked. Pawn has non-capturing moves, so we exclude those. 
    @pieces.reduce([]) {|moves, piece| moves.concat(piece.moves.filter_map {|m| m[:position] if m[:type] != :move_only})}.uniq
  end

  def update_moves()
    @pieces.each {|piece| piece.update_moves}
  end

  def update_king_moves(check_positions)
    @king = @pieces.select {|piece| piece.name == 'king'}[0] if @king.nil? 
    @king.update_moves()
    @king.filter_moves(check_positions) 
  end
end