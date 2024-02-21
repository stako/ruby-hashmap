# frozen_string_literal: true

require_relative 'hash_map/node'

# Personal hash map implementation
class HashMap
  def initialize
    @capacity = 16
    @load_factor = 0.75
    @buckets = Array.new(@capacity)
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def set(key, value)
    index = hash(key) % @capacity
    raise IndexError if index.negative? || index >= @buckets.length

    @buckets[index] = Node.new(key, value)
  end

  def get(key)
    index = hash(key) % @capacity

    @buckets[index].value
  end

  def length
    @buckets.count { |element| !element.nil? }
  end
end
