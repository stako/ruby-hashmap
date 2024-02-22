# frozen_string_literal: true

# Personal hash map implementation
class HashMap
  def initialize(default_capacity = 16)
    @default_capacity = default_capacity
    @capacity = default_capacity
    @load_factor = 0.75
    @buckets = Array.new(@capacity)
  end

  def set(key, value)
    index = get_index(key)

    list = @buckets[index].nil? ? LinkedList.new : @buckets[index]
    @buckets[index] = list

    node = list.get_node(key)
    node ? node.value = value : list.append(key, value)
  end

  def get(key)
    @buckets[get_index(key)]&.get_node(key)&.value
  end

  def has(key)
    @buckets[get_index(key)]&.get_node(key) ? true : false
  end

  def remove(key)
    list = @buckets[get_index(key)]
    node = list&.get_node(key)
    return nil if node.nil?

    list.remove(node)
    node.value
  end

  def length
    @buckets.count { |element| !element.nil? }
  end

  def clear
    @capacity = @default_capacity
    @buckets.clear
    @buckets.fill(nil, 0, @default_capacity)
  end

  private

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def get_index(key)
    index = hash(key) % @capacity
    raise IndexError if index.negative? || index >= @buckets.length

    index
  end
end
