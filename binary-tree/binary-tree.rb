class Node
  include Comparable
  attr_accessor :data, :left_child, :right_child

  def initialize(data = nil, left_child = nil, right_child =nil)
    @data = data
    @left_child = left_child
    @right_child = right_child
  end

  def <=> (other)
    @data <=> other.data
  end

end

n1 = Node.new(1)
n2 = Node.new(2)

p n1 > n2
p n2 > n1