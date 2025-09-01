class PositionNode
  attr_accessor :position, :previous_node, :moveable_nodes
  def initialize(position, previous_node = nil)
    @position = position
    @previous_node = previous_node
    @moveable_nodes = []
  end
end

class Board
  def initialize
    @next_position_deltas = [[2,1],[1,2],[-1,2],[-2,1],[-2,-1],[-1,-2],[1,-2],[2,-1]]
  end

  def knight_moves(start_position, end_pos)
    starting_node = PositionNode.new(start_position)
    end_node = nil
    positions_queue = [starting_node]
    checked_positions =[]

    until positions_queue.empty?
      current_node = positions_queue.shift
      checked_positions << current_node.position
      next_positions = get_next(current_node.position)
      next_positions.filter! {|pos| !checked_positions.include?(pos)}

      next_positions.each do |pos|
        next_node = PositionNode.new(pos, current_node)
        current_node.moveable_nodes << next_node
        positions_queue << next_node
        if pos == end_pos
         end_node = next_node
         positions_queue = []
         break
        end
      end
    end

    node = end_node
    path = []
     until node.nil?
       path << node.position
       node = node.previous_node
     end
     path.reverse
  end

  def get_next(postion)
    next_positions = []
    @next_position_deltas.each do |delta|
      next_position = [postion[0] + delta[0], postion[1] + delta[1]]
      next_positions << next_position if next_position[0].between?(0,7) && next_position[1].between?(0,7)
    end
    next_positions
  end
end



board = Board.new
p board.knight_moves([0,0],[3,3])
p board.knight_moves([3,3],[0,0])
p board.knight_moves([0,0],[7,7])