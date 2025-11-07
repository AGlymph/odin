require_relative '../lib/connect_four_board'

describe ConnectFourBoard do 
  describe "#initialize" do
    rows = 6
    columns = 7
    subject(:new_board) {described_class.new(columns: columns,rows: rows)}
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

  describe "#insert_piece" do
    rows = 6
    columns = 7
    context 'when the column is not full' do
        subject(:empty_board) {described_class.new(columns: columns,rows: rows)}
        it 'the first piece goes into the bottom slot' do 
          piece = 'x'
          column = 3  
          inserted_row = empty_board.insert_piece(column, piece)
          expect(inserted_row).to eq(rows)
        end

        it 'the placeholder is replaced with the piece' do 
          piece = 'x'
          column = 3  
          col_index = column - 1
          inserted_row = empty_board.insert_piece(column, piece)
          inserted_index = rows - inserted_row
          inserted_piece = empty_board.grid[col_index][inserted_index]
          expect(inserted_piece).to eq(piece)
        end

        it 'mutltiple pieces stack' do 
          piece = 'x'
          column = 3  
          empty_board.insert_piece(column, piece)
          empty_board.insert_piece(column, piece)
          inserted_row = empty_board.insert_piece(column, piece)
          expect(inserted_row).to eq(4)
        end
    end 
    context 'when the column is full' do
       full_grid = [['x','x','x']]
       subject(:full_board) {described_class.new(columns: columns,rows: rows, grid: full_grid)}
        it 'the piece is not put into the column' do
          inserted_row = full_board.insert_piece(1, 'x')
          expect(inserted_row).to be_nil
        end
    end  
  end

  describe '#full?' do
    context 'when the board has positions without a piece'  do
      empty_space = ' '
      grid = [['x',empty_space,'o','x'], [empty_space,'o','o','x'], [empty_space,'o','o','o']]
      subject(:empty_board) {described_class.new(placeholder: empty_space, grid: grid)}
      it 'returns false' do
        expect(empty_board.full?).to be false
      end
    end
    context 'when the board has all positions with a piece'  do
      empty_space = ' '
      grid = [['x','x','o','x'], ['x','o','o','x'], ['x','o','o','o']]
      subject(:full_board) {described_class.new(placeholder: empty_space, grid: grid)}
      it 'returns false' do
        expect(full_board.full?).to be true
      end
    end

  end

  describe '#chain_length' do 
    context 'when a piece is touching other matching pieces in a column' do
      grid = [['x','x','x']]
      subject(:chain_board) {described_class.new(grid: grid)}
      it 'returns the length of the number of pieces touching in the col' do
        longest_chain_length = chain_board.chain_length([1,1], 'x')
        expect(longest_chain_length).to eq(3)
      end
    end
    context 'when a piece is mixed with other pieces in a column' do
      grid = [['x','o','o','x']]
      subject(:chain_board) {described_class.new(grid: grid)}
      it 'returns the length of the number of pieces touching in the col' do
        longest_chain_length = chain_board.chain_length([1,3], 'o')
        expect(longest_chain_length).to eq(2)
      end
    end
    context 'when the longest chain is in the row chain' do
      grid = [['x','o','o','x'], ['o','o','o','x'], ['o','o','o','o']]
      subject(:chain_board) {described_class.new(grid: grid)}
      it 'returns the length of the number of pieces touching in the row for the given position' do
        longest_chain_length = chain_board.chain_length([1,1], 'x')
        expect(longest_chain_length).to eq(2)
      end

       it 'returns the length of the number of pieces touching in the row for the given position and piece' do
        longest_chain_length = chain_board.chain_length([2,2], 'o')
        expect(longest_chain_length).to eq(3)
      end
    end
    context 'when the longest chain is in a diagonal' do
      grid = [['0','o','o','x'], ['o','o','x','0'], ['o','x','o','o']]
      subject(:chain_board) {described_class.new(grid: grid)}
      it 'returns the length of the number of pieces touching in the row for the given position at start of chain' do
        longest_chain_length = chain_board.chain_length([1,1], 'x')
        expect(longest_chain_length).to eq(3)
      end

      it 'returns the length of the number of pieces touching in the row for the given position in middle of chain' do
        longest_chain_length = chain_board.chain_length([2,2], 'x')
        expect(longest_chain_length).to eq(3)
      end
    end
  end
  
end

# user selects col
# if the col is full it cannot take a piece
# the piece drops to the first available position 