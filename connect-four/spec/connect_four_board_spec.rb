require_relative '../lib/connect_four_board'

describe ConnectFourBoard do 
  describe "#initialize" do
    rows = 6
    columns = 7
    subject(:new_board) {described_class.new(columns,rows)}
    context 'when a board is created' do
      it 'rows is greater than 0' do
        expect(new_board.rows).to be > 0
      end
      it 'columns is greater than 0' do
        expect(new_board.columns).to be > 0
      end
      it 'grid has columns equal to the columns' do
        number_columns = new_board.grid.length 
        expect(number_columns).to eq(columns)
      end
      it 'grid has rows equal to the rows' do
        number_rows = new_board.grid[0].length 
        expect(number_rows).to eq(rows)
      end
    end
  end
  










end

# makes a grid of nodes that is 7x6 
# 
# expect it to receive node .new 42 times 