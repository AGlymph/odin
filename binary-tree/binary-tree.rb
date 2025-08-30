class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data = nil)
    @data = data
    @left= nil
    @right = nil
  end

  def <=> (other)
    @data <=> other.data
  end

end

class Tree
  
  def initialize(array = nil)
    array = array.uniq
    array.sort!
    @root = build_tree(array)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def build_tree(array)
    return nil if array.empty?

    mid_index = (array.length-1) / 2
    node = Node.new(array[mid_index])
    node.left = build_tree(array[0...mid_index])
    node.right = build_tree(array [mid_index + 1...array.length])

    return node
  end


  def insert(node = @root, value)
    return Node.new(value) if node.nil? 
    return node if value == node.data 

    if value < node.data 
      node.left = insert(node.left, value)
    else 
      node.right = insert(node.right,value)
    end

    return node
  end

  def delete (node = @root, value)
    return nil if node.nil?

    if value < node.data
      node.left = delete(node.left, value)
    elsif value > node.data
      node.right = delete(node.right,value)
    else 
      # no children or 1 child
      # return nil if node.left.nil? && node.right.nil? 
      # 1 child
      return node.right if node.left.nil? 
      return node.left if node.right.nil? 
      # 2  children 
      # Get the next biggets node
      # go right once
      # go left until nil 
      # swap data values 
      # delete the next node
      next_node = node.right
      until next_node.left.nil? 
        next_node = next_node.left
      end
      node.data = next_node.data
      node.right = delete(node.right, next_node.data)
    end 

    return node
  end

  def find(node = @root, value)
    return node if value == node.data 

    if value < node.data 
      return find(node.left, value)
    else 
      return find(node.right,value)
    end
  end

  def level_order(&block)
    return_value = nil
    unless block_given? 
      return_value = []
      block = lambda {|node| return_value << node.data}
    end
    
    queue = [@root]
    until queue.empty? 
      queue << queue[0].left unless queue[0].left.nil?
      queue << queue[0].right unless queue[0].right.nil?
      block.call(queue.shift)
    end

    return return_value
  end


end

tree = Tree.new([1,2,4,3,5,6,7,8,9])
tree.pretty_print
p tree.level_order {|node| puts node.data}
p tree.level_order