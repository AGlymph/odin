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
      node.right = node 
      #todo finish
    end

    return node 
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end

tree = Tree.new([2,4,3,5,6])
tree.pretty_print
tree.insert(1)
tree.pretty_print

