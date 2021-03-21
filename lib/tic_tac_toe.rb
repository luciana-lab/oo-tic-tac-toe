require 'pry'
class TicTacToe

    def initialize
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    WIN_COMBINATIONS = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8],
        [0, 3, 6], [2, 5, 8],[1, 4, 7],
        [0, 4, 8], [2, 4, 6]
    ]

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(string)
        string.to_i - 1
# converts the user's input from the user-friendly format (on a 1-9 scale) to the array-friendly format (where the first index starts at 0)
    end

    def move(index, token)
        @board[index] = token
    end

    def position_taken?(index)
        if @board[index] == " "
            false
        else
            true
        end
    end

    #returns true/false based on whether the position is already occupied
    #checks that the attempted move is within the bounds of the game board
    def valid_move?(index)
        if !position_taken?(index) && (0..8).include?(index)
            true
        else
            false
        end
    end

    #counts occupied positions
    def turn_count
        @board.count {|token| token == "X" || token == "O"}
    end

    def current_player
        if turn_count.even?
            "X"
        else
            "O"
        end
        #turn_count.even? ? "X" : "O" => another way to do it in 1 line

    end

    #1. Ask the user for their move by specifying a position between 1-9.
    #2. Receive the user's input.
    #3. Translate that input into an index value.
    #4. If the move is valid, make the move and display the board.
    #5. If the move is invalid, ask for a new move until a valid move is received.
    #receives user input via the gets method
    #calls #input_to_index, #valid_move?, and #current_player
    #makes valid moves and displays the board
    #asks for input again after a failed validation
    def turn
        #puts "Specify a position between 1-9: "
        user_input = gets.strip
        index_num = input_to_index(user_input)
        if valid_move?(index_num)
            move(index_num, current_player)
            display_board
        else
            turn
        end
    end

    #returns false for a draw
    #returns the winning combo for a win
    #position_taken checks to make sure it's not empty, has "X" or "O"
    def won?
        WIN_COMBINATIONS.detect do |win_combo| 
        @board[win_combo[0]] == @board[win_combo[1]] && 
        @board[win_combo[1]] == @board[win_combo[2]] && 
        position_taken?(win_combo[0])   
        end
    end

    #The `#full?` method should return `true` if every element in the board contains either an "X" or an "O".
    def full?
        #if @board.any?(" ") return false 
        @board.all? {|token| token == "X" || token == "O"}
    end

    #Build a method `#draw?` that returns `true` if the board is full and has not
#been won and `false` otherwise.
    def draw?
        full? && !won?
    end

    #Build a method `#over?` that returns `true` if the board has been won or is full
#(i.e., is a draw).
    def over?
        won? || draw?
    end

    #Given a winning `@board`, the `#winner` method should return the token, `"X"` or
#`"O"`, that has won the game.
    def winner
        if win_combo = won?
            @board[win_combo.first]
        end
    end

    def play
        while !over?
            turn
        end
        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end


end