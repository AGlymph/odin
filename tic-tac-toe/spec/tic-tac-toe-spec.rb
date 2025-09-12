require_relative '../lib/tic-tac-toe'

describe TicTacToeGame do
  describe '#winner?' do     
     context 'when a row is filled with one player' do
        x = 'X'
        placeholder = ' ' 
        board = [[x,x,x],[placeholder ,placeholder ,placeholder],[placeholder ,placeholder ,placeholder]]
        subject(:row_winning_game) {described_class.new(board: board)}
        it 'returns true' do
          is_winner = row_winning_game.winner?(x)
          expect(is_winner).to be(true)
        end
    end
    context 'when a column is filled with one player' do
        x = 'X'
        placeholder = ' ' 
        board = [[x,placeholder, placeholder],[x ,placeholder ,placeholder],[x ,placeholder ,placeholder]]
        subject(:row_winning_game) {described_class.new(board: board)}
        it 'returns true' do
          is_winner = row_winning_game.winner?(x)
          expect(is_winner).to be(true)
        end
    end
    context 'when L to R diagonal is filled with one player' do
        x = 'X'
        placeholder = ' ' 
        board = [[x,placeholder, placeholder],[placeholder ,x ,placeholder],[placeholder,placeholder ,x]]
        subject(:row_winning_game) {described_class.new(board: board)}
        it 'returns true' do
          is_winner = row_winning_game.winner?(x)
          expect(is_winner).to be(true)
        end
    end
    context 'when R to L diagonal is filled with one player' do
        x = 'X'
        placeholder = ' ' 
        board = [[placeholder,placeholder, x],[placeholder ,x ,placeholder],[x,placeholder ,placeholder]]
        subject(:row_winning_game) {described_class.new(board: board)}
        it 'returns true' do
          is_winner = row_winning_game.winner?(x)
          expect(is_winner).to be(true)
        end
    end

    context 'when a row, column, or diagonal is not filled with one player' do
        x = 'X'
        placeholder = ' ' 
        board = [[placeholder ,x ,placeholder],[placeholder ,placeholder ,placeholder],[placeholder ,x ,placeholder]]
        subject(:row_winning_game) {described_class.new(board: board)}
        it 'returns false' do
          is_winner = row_winning_game.winner?(x)
          expect(is_winner).to be(false)
        end
    end
  end











end