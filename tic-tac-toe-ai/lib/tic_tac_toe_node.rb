require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []

    @board.each do |row|
      row.each do |col|
        pos = [row, col]
        if board[pos].empty?
          child_board = board.dup[pos] = next_mover_mark
          next_mark = next_mover_mark == :x ? :o : :x
          children << TicTacToeNode.new(child_board,
                                        next_mark,
                                        pos)
        end
      end
    end

    children
  end
end
