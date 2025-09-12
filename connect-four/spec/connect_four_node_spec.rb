require_relative '../lib/connect_four_node'

describe ConnectFourNode do
  describe '#initialize' do 
    context 'when a node is initialized' do
      subject(:new_node) {described_class.new()}
      it 'piece is empty' do
        piece = new_node.piece
        expect(piece).to be_nil
      end

      it 'has room for 8 edges' do 
      number_edges = new_node.edges.length 
      expect(number_edges).to eq(8)
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

    context 'when the nodes edge attempted to be set' do
      let(:child_node) {described_class.new()}
      it 'sets the 1st edge to the other node' do
        update_node.edges[0] = child_node
        edge = update_node.edges[0]
        expect(edge).to be(child_node)
      end

      it 'sets the 8th edge to the other node' do
        update_node.edges[7] = child_node
        edge = update_node.edges[7]
        expect(edge).to be(child_node)
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