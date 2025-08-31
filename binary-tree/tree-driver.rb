require_relative 'binary-tree.rb'


tree = Tree.new(Array.new(15) { rand(1..100) })
puts tree.balanced?
tree.pretty_print
p tree.level_order
p tree.preorder
p tree.postorder
p tree.inorder

5.times do 
  tree.insert(rand(101..125))
end

puts tree.balanced?
tree.pretty_print
tree.rebalance
puts tree.balanced?
tree.pretty_print
p tree.level_order
p tree.preorder
p tree.postorder
p tree.inorder
