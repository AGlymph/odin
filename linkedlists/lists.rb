class LinkedList
  def initialize
    @head = nil
  end

  def append(value)
    if @head.nil?
      prepend(value)
    else
      node = @head
      node = node.next_node while node.next_node
      node.next_node = Node.new(value)
    end
  end

  def prepend(value)
    @head = Node.new(value, @head)
  end

  def to_s
    node = @head
    list_string = ''
    until node.nil?
      list_string += "(#{node.value})-> "
      node = node.next_node
    end
    "#{list_string}nil"
  end

  def size
    node = @head
    size = 0
    until node.nil?
      size += 1
      node = node.next_node
    end
    size
  end

  def head
    @head.value
  end

  def tail
    node = @head
    node = node.next_node while node.next_node
    node.value
  end

  def at(index)
    node = @head
    current_index = 0
    while node.next_node && current_index < index
      node = node.next_node
      current_index += 1
    end
    node.value
  end

  def pop
    return @head = nil if @head.nil? || @head.next_node.nil?

    previous = @head
    current = @head.next_node
    while current.next_node
      previous = current
      current = current.next_node
    end
    previous.next_node = nil
  end

  def contains?(value)
    node = @head
    node = node.next_node until node.nil? || node.value == value
    !node.nil?
  end

  def find(value)
    node = @head
    current_index = 0
    until node.nil? || node.value == value
      node = node.next_node
      current_index += 1
    end
    node.nil? ? nil : current_index
  end
end

class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

class HashNode
  attr_accessor :key, :value, :next_node

  def initialize(key = nil, value = nil, next_node = nil)
    @key = key
    @value = value
    @next_node = next_node
  end
end

class HashLinkedList
  def initialize
    @head = nil
  end

  def append(key, value)
    if @head.nil?
      @head = HashNode.new(key,value, @head)
    else
      node = @head
      node = node.next_node while node.next_node
      node.next_node = HashNode.new(key,value)
    end
  end

  def find_value(key)
    node = @head
    node = node.next_node until node.nil? || node.key == key
    node.nil? ? nil : node.value
  end

  def remove(key)
    if @head.key == key
      value = @head.value 
      @head = @head.next_node.nil? ? nil : @head.next_node
      return value
    end

    previous = @head
    current = @head.next_node
    until current.next_node.nil? || current.key == key
      previous = current
      current = current.next_node
    end

    if current.key == key 
      previous.next_node = current.next_node 
      value = current.value
      current = nil
      return value
    end
    
    nil
  end

  def length
    node = @head
    current_index = 0
    until node.nil?
      node = node.next_node
      current_index += 1
    end
    current_index
  end

  def keys
    node = @head
    keys = Array.new()
    until node.nil?
      keys << node.key
      node = node.next_node
    end
    keys
  end

  def values
    node = @head
    values = Array.new()
    until node.nil?
      values << node.value
      node = node.next_node
    end
    values
  end

  def entries
    node = @head
    entries = Array.new()
    until node.nil?
      entries << [node.key, node.value]
      node = node.next_node
    end
    entries
  end

  def to_s
    node = @head
    list_string = ''
    until node.nil?
      list_string += "(#{node.key}: #{node.value})-> "
      node = node.next_node
    end
    "#{list_string}nil"
  end
end


=begin
list = LinkedList.new

list.append('dog')
list.append('cat')
list.append('parrot')
list.append('hamster')

puts list
puts list.size
puts list.head
puts list.tail
puts list.at(2)
puts list.contains?('dog')
p list.find('cat')
list.pop

puts list
=end