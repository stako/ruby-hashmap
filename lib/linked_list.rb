# frozen_string_literal: true

Node = Struct.new('Node', :key, :value, :prev_node, :next_node)

# Linked List class
class LinkedList
  attr_reader :head

  def append(key, value)
    return @head = Node.new(key, value) if @head.nil?

    tmp = @head
    tmp = tmp.next_node until tmp.next_node.nil?
    tmp.next_node = Node.new(key, value, tmp)
  end

  def get_node(key)
    return nil if @head.nil?

    node = @head
    until node.nil?
      return node if node.key == key

      node = node.next_node
    end

    nil
  end

  def remove(node)
    @head = node.next_node if node == @head
    node.next_node.prev_node = node.prev_node if node.next_node
    node.prev_node.next_node = node.next_node if node.prev_node
  end
end
