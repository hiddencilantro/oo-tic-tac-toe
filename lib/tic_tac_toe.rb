class TicTacToe

    def initialize
        @board = Array.new(9, " ")
    end

    WIN_COMBINATIONS = [
        [0, 1, 2], #top row
        [3, 4, 5], #middle row
        [6, 7, 8], #bottom row
        [0, 3, 6], #left column
        [1, 4, 7], #middle column
        [2, 5, 8], #right column
        [0, 4, 8], #left to right diagonal
        [2, 4, 6] #right to left diagonal
    ]

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def move(index, token = "X")
        @board[index] = token
    end

    def position_taken?(index)
        @board[index] != " "
    end

    def valid_move?(index)
        index.between?(0,8) && !position_taken?(index)
    end

    def turn
        puts "Enter 1-9:"
        input = gets
        num = input_to_index(input)
        if valid_move?(num)
            move(num, current_player)
        else
            turn
        end
        display_board
    end

    def turn_count
        @board.count{|token| token == "X" || token == "O"}
    end

    def current_player
        turn_count % 2 == 0 ? "X" : "O"
    end

    def won?
        WIN_COMBINATIONS.detect do |combination|
            @board[combination[0]] == @board[combination[1]] && @board[combination[1]] == @board[combination[2]] && position_taken?(combination[0])
        end
    end

    def full?
        !(@board.any? {|space| space == " "})
    end

    def draw?
        if full? && !won?
            true
        else
            false
        end
    end

    def over?
        won? || draw?
    end

    def winner
        if combination = won?
            @board[combination[0]]
        end
    end

    def play
        turn until over?
        if won?
        puts "Congratulations #{winner}!"
        elsif draw?
        puts "Cat's Game!"
        end
    end

end