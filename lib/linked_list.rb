# frozen_string_literal: true

Node = Struct.new('Node', :key, :value, :prev_node, :next_node)

# Linked List class
class LinkedList
  def append(key, value)
    return @head = Node.new(key, value) if @head.nil?

    tmp = @head
    tmp = tmp.next_node until tmp.next_node.nil?
    tmp.next_node = Node.new(key, value, tmp)
  end

  def get_node(key)
    return nil if @head.nil?

    node = @head
    loop do
      return node if node.key == key

      node = node.next_node
      break if node.next_node.nil?
    end

    nil
  end
end
