class ConnectFourNode
  attr_accessor :piece, :relationships, :position

  def initialize (postion = nil)
    @position = postion
    @piece = nil
    @relationships = Array.new(8)
  end
end 