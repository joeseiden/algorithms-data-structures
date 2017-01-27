class PolyTreeNode
  attr_reader :parent, :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    @parent.children.delete(self) unless parent.nil?
    @parent = node
    @parent.children << self unless node.nil?
  end

  def add_child(child_node)
    child_node.parent = self
    children << child_node unless children.include?(child_node)
  end

  def remove_child(child_node)
    raise "not a child" unless children.include?(child_node)
    child_node.parent = nil
    children.delete(child_node)
  end

  def dfs(target_value)
    return self if self.value == target_value

    children.each do |child|
      result = child.dfs(target_value)
      return result if result
    end

    nil
  end

  def bfs(target_value)
    queue = [self]

    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      queue += node.children
    end

    nil
  end
end

if __FILE__ == $PROGRAM_NAME
  # poly = PolyTreeNode.new("a")
  # poly2 = PolyTreeNode.new("b")
  # poly.parent = poly2
  # poly2.add_child(poly)
  # p poly.parent
  # p poly.children
  d = PolyTreeNode.new("d")
  e = PolyTreeNode.new("e")
  y = PolyTreeNode.new("y")
  o = PolyTreeNode.new("o")
  o.add_child(d)
  o.add_child(e)
  s = PolyTreeNode.new("s")
  s.add_child(y)
  n = PolyTreeNode.new("n")
  n.add_child(o)
  n.add_child(s)
end
