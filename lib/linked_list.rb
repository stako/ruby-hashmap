# frozen_string_literal: true

Node = Struct.new('Node', :key, :value, :next_node)

# Linked List class
class LinkedList
  attr_reader :head

  def append(key, value)
    return @head = Node.new(key, value) if @head.nil?

    tmp = @head
    tmp = tmp.next_node until tmp.next_node.nil?
    tmp.next_node = Node.new(key, value)
  end
end
