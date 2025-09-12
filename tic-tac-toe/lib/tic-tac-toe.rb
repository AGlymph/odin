# final output: 
# X|O|X 
# X|X|O
# X|O|O
# X: Wins! 

class TicTacToeGame
 
  def initialize (players: ['X','O'], placeholder: ' ', board: Array.new(3){Array.new(3){placeholder}})
    @players = players
    @placeholder = placeholder
    @board = board
    @winner = nil
    @is_board_full = false
  end

  def get_board_position(player)
    position = Array.new(2,0)
      while !position_valid?(position) do 
        puts "Select Row: 1,2 or 3"
        position[0] = gets.chomp.slice(0).to_i
        puts "Select Column: 1,2 or 3"
        position[1] = gets.chomp.slice(0).to_i
        puts "You choose:  #{position[0]}, #{position[1]}"
      end
    position.map! { |p| p - 1} # input is 1 indexed
    @board[position[0]][position[1]] = player
  end

  def position_valid?(position)
     position.all?{|p| [1,2,3].include?(p)} &&
     @board[position[0] - 1][position[1]- 1] == @placeholder
  end

  def show_board
    @board.each { |row| puts "#{row[0]}|#{row[1]}|#{row[2]}"}
  end

  def winner?(player)
    if @board.any? {|row| row.uniq.include?(player) && row.uniq.length == 1} # check rows are all the same 
      return true
    elsif @board.transpose.any? {|col| col.uniq.include?(player) && col.uniq.length == 1} # check columns are all the same
      return true
    elsif @board[1][1] == player && @board[0][0] == @board[1][1] &&  @board[1][1] == @board[2][2] # L to R diagonal
      return true
    elsif @board[1][1] == player  && @board[0][2] == @board[1][1] &&  @board[1][1] == @board[2][0] # R to L diagonal
      return true
    else 
      return false
    end
  end

  def board_full?
    !@board.flatten.include?(@placeholder)
  end

  def game_over?
    board_full? || !@winner.nil?
  end

  def do_turn(player)
    puts "#{player}'s Turn!"
    get_board_position(player)
    show_board
    @winner = winner?(player) ? player : nil
  end


  def play
    loop do
      do_turn(@players[0])
      break if game_over?
      do_turn(@players[1])
      break if game_over?
    end
  end

 def show_result
   if @winner
     puts "#{@winner} won!"
   else
    puts "Draw!"
   end
 end
 
end



# game = TicTacToeGame.new()
# game.play
# game.show_result