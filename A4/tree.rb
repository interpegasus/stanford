class TreeNode
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

class BinarySearchTree
  attr_accessor :root, :size

  def initialize()
    @root = nil
    @size = 0
  end

  def insert(value)
    if @root == nil
      @root = TreeNode.new(value)
    else
      current_node = @root
      previous_node = @root
      #while loop helps finding the position of insertion
      while current_node != nil
        previous_node = current_node
        if value < current_node.value
          current_node = current_node.left
        else
          current_node = current_node.right
        end
      end
      if value < previous_node.value
        previous_node.left = TreeNode.new(value)
      else
        previous_node.right = TreeNode.new(value)
      end
    end
    @size += 1
  end

  def find_max(node = self.root)
    if node == nil
      return nil
    elsif node.right == nil
      return node
    end
    return find_max(node.right)
  end

  def find_min(node = self.root)
    if node == nil
      return nil
    elsif node.left == nil
      return node
    end
    return find_min(node.left)
  end

  def print_in_order(node = self.root)
    if node != nil
      print_in_order(node.left)
      print "#{node.value} "
      print_in_order(node.right)
    end
  end

  def print_pre_order(node = self.root)
    if node != nil
      print "#{node.value} "
      print_pre_order(node.left)
      print_pre_order(node.right)
    end
  end

  def print_pos_order(node = self.root)
    if node != nil
      print_pos_order(node.left)
      print_pos_order(node.right)
      print "#{node.value} "
    end
  end
end

def generate_binary_search_tree
  bst = BinarySearchTree.new()
  100.times do
    bst.insert(rand(1..10000000))
  end
  return bst
end
