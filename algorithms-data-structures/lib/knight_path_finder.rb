require_relative '00_tree_node'

class KnightPathFinder

  MOVES = [
    [-2,1],
    [-2,-1],
    [-1,-2],
    [1,-2],
    [2,-1],
    [2,1],
    [1,2],
    [-1,2]
  ]

  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = [start_pos]
  end

  def new_move_positions(pos)
    new_pos = KnightPathFinder.valid_moves(pos).reject do |move|
      @visited_positions.include?(move)
    end

    @visited_positions += new_pos
    new_pos
  end

  def self.valid_moves(pos)
    row, col = pos
    potential_moves = []

    MOVES.each do |coord|
      new_coord = [row + coord.first, col + coord.last]
      potential_moves << new_coord unless new_coord.any? { |el| el < 0 or el > 7 }
    end

    potential_moves
  end
end
