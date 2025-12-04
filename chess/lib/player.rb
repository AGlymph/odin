class Player
  attr_reader :pieces, :color, :starting_row
  def initialize (color)
    @color = color 
    @pieces = []

    if @color == :white 
      piece_set = 'rnbqkbnrpppppppp'
      @starting_row = '1'
    else 
      piece_set = 'PPPPPPPPRNBQKBNR'
      @starting_row = '7'
    end

    piece_set.each_char do |piece_icon|
      piece = Piece.new(piece_icon, @color)
      @pieces.push(piece)
    end
  end
end