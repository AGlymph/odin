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

  describe '#position_valid?' do
      x = 'X'
      placeholder = ' ' 
      board_partial_filled = [[placeholder ,x ,placeholder],[placeholder ,placeholder ,placeholder],[placeholder ,x ,placeholder]]
      subject(:valid_position_game) {described_class.new(board: board_partial_filled)}

      context 'when the player enters inputs with values 1,2, or 3'do
        it 'returns true when the space is empty' do
          user_input = [3,1]
          is_valid = valid_position_game.position_valid?(user_input)
          expect(is_valid).to be(true)
        end

        it 'returns false when the space is filled' do
          user_input = [1,2]
          is_valid = valid_position_game.position_valid?(user_input)
          expect(is_valid).to be(false)
        end
      end
      
      context 'when the player enters an values not 1,2, or 3'do
        it 'returns false' do
          user_input = ['4',9]
          is_valid = valid_position_game.position_valid?(user_input)
          expect(is_valid).to be(false)
        end
      end
  end

  describe '#get_board_position' do
    subject(:game_loop) {described_class.new()}
    context 'when the user inputs an invalid guess then a valid guess' do
      before do 
        invalid_guess = ['1','5']
        valid_guess = ['1','1']
        allow(game_loop).to receive(:gets).and_return(invalid_guess[0],invalid_guess[1],valid_guess[0],valid_guess[1])
      end

      it 'it loops once then sets the position' do
        player = 'X'
        board = game_loop.instance_variable_get(:@board)
        expect(board[0][0]).not_to eq(player)
        game_loop.get_board_position(player)
        board = game_loop.instance_variable_get(:@board)
        expect(board[0][0]).to eq(player)
      end
      
    end
    context 'when the enters a valid guess ' do
       before do 
        valid_guess = ['3','3']
        allow(game_loop).to receive(:gets).and_return(valid_guess[0],valid_guess[1])
      end

      it 'sets board position to O for player O' do
        player = 'O'
        board = game_loop.instance_variable_get(:@board)
        expect(board[2][2]).not_to eq(player)
        game_loop.get_board_position(player)
        board = game_loop.instance_variable_get(:@board)
        expect(board[2][2]).to eq(player)
      end
    end
  end

  describe '#board_full?' do
    
    context 'when the board has no more placeholders' do
      x = 'X'
      board = [[x,x,x],[x ,x ,x],[x ,x ,x]]
      subject(:full_game_board) {described_class.new(board: board)}
      it 'returns true' do
        expect(full_game_board).to be_board_full
      end
    end

    context 'when there are placeholders' do
    x = 'X'
    placeholder = ' '
    board = [[x,x,x],[placeholder ,placeholder ,placeholder],[placeholder ,placeholder ,placeholder]]
    subject(:game_board) {described_class.new(board: board)}
    it 'returns false' do
      expect(game_board).not_to be_board_full
    end
  end

  end


end