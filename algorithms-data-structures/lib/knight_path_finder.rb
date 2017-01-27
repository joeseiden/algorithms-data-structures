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

  def find_path(end_pos)
    trace_path_back(@move_tree.bfs(end_pos))
  end

  def trace_path_back(node)
    path = [node]

    until path.first.parent.nil?
      path.unshift(path.first.parent)
    end

    path.map { |node| node.value }
  end

  def build_move_tree
    @move_tree = PolyTreeNode.new(@start_pos)

    queue = [@move_tree]
    until queue.empty?
      node = queue.shift
      node_pos = node.value

      new_positions = new_move_positions(node_pos)

      new_positions.each do |pos|
        node.add_child(PolyTreeNode.new(pos))
      end

      queue += node.children
    end

    @move_tree
  end

  def new_move_positions(pos)
    possible_moves = KnightPathFinder.valid_moves(pos).reject do |move|
      @visited_positions.include?(move)
    end

    @visited_positions.concat(possible_moves)
    possible_moves
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

if __FILE__ == $PROGRAM_NAME
  start_time = Time.new
  k = KnightPathFinder.new([0,0])
  k.build_move_tree
  p k.find_path([6,2])
  end_time = Time.new
  puts "#{end_time - start_time}"
end
