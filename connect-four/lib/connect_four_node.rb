class ConnectFourNode
  attr_accessor :piece, :edges

  def initialize
    @piece = nil
    @edges = Array.new(8)
  end
end