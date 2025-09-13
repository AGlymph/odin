require_relative '../lib/connect_four_node'

describe ConnectFourNode do
  describe '#initialize' do 
    context 'when a node is initialized' do
      position = [1,1]
      subject(:new_node) {described_class.new(position)}
      it 'piece is empty' do
        piece = new_node.piece
        expect(piece).to be_nil
      end

      it 'has room for 8 relationships' do 
      number_relationships = new_node.relationships.length 
      expect(number_relationships).to eq(8)
      end 

      it 'receives a position' do 
      node_position = new_node.position
      expect(node_position).to eq(position)
      end 
    end 
  end

  describe 'setters' do 
    subject(:update_node) {described_class.new()}
    context 'when the nodes piece attempted to be set' do
      it 'sets the piece value' do
        piece_value = '@'
        update_node.piece = piece_value
        expect(update_node.piece).to eq(piece_value)
      end
    end

    context 'when the nodes relationship attempted to be set' do
      let(:child_node) {described_class.new()}
      it 'sets the 1st relationship to the other node' do
        update_node.relationships[0] = child_node
        relationship = update_node.relationships[0]
        expect(relationship).to be(child_node)
      end

      it 'sets the 8th relationship to the other node' do
        update_node.relationships[7] = child_node
        relationship = update_node.relationships[7]
        expect(relationship).to be(child_node)
      end
    end
  end
  
end

# graph 
# each slot is a node
# each node can hold one piece
# each node has an edge to their adjacent nodes 
# 
#
# board class (other tests)
# the first node is the head node
# it has no parent node 
# 
#