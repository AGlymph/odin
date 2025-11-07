require_relative 'connect_four_board'

class ConnectFour 

  def initialize (players: ['X','O'], board: ConnectFourBoard.new())
    @players = players
    @board = board 
    @winner = nil 
  end

  def game_over?
    @board.full? || !@winner.nil?
  end

  def do_turn(player)
      inserted_row = nil 
      puts "#{player}'s Turn!"
      while inserted_row.nil? do 
        puts "Select a column: "
        column = gets.chomp.slice(0).to_i
        if column.between?(1, @board.columns)
          inserted_row = @board.insert_piece(column, player)
        end 
      end 

      position = [column, inserted_row]
      chain_length = @board.chain_length(position, player)
      if chain_length == 4 
        @winner = player 
      end
  end


 def show_result
   if @winner
     puts "#{@winner} won!"
   else
    puts "Draw!"
   end
 end

  
 def play
   puts "//LET'S PLAY CONNECT 4//"
    @board.show
    loop do
      do_turn(@players[0])
      @board.show
      break if game_over?
      do_turn(@players[1])
      @board.show
      break if game_over?
    end
    show_result
 end

end

game = ConnectFour.new();
game.play();