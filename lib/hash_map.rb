# frozen_string_literal: true

# Personal hash map implementation
class HashMap
  attr_reader :length

  def initialize(default_capacity = 16)
    @default_capacity = default_capacity
    @capacity = default_capacity
    @length = 0
    @buckets = Array.new(@capacity)
  end

  LOAD_FACTOR = 0.75

  def set(key, value)
    increase_capacity if overloaded?

    index = get_index(key)

    list = @buckets[index].nil? ? LinkedList.new : @buckets[index]
    @buckets[index] = list

    node = list.get_node(key)
    node ? node.value = value : list.append(key, value)
    @length += 1 if node.nil?
  end

  def get(key)
    @buckets[get_index(key)]&.get_node(key)&.value
  end

  def has?(key)
    @buckets[get_index(key)]&.get_node(key) ? true : false
  end

  def remove(key)
    list = @buckets[get_index(key)]
    node = list&.get_node(key)
    return nil if node.nil?

    list.remove(node)
    @length -= 1
    node.value
  end

  def clear
    @capacity = @default_capacity
    @buckets.clear
    @buckets.fill(nil, 0, @default_capacity)
    @length = 0
  end

  def keys
    key_list = []
    loop_nodes { |node| key_list.push(node.key) }
    key_list
  end

  def values
    value_list = []
    loop_nodes { |node| value_list.push(node.value) }
    value_list
  end

  def entries
    entry_list = []
    loop_nodes { |node| entry_list.push([node.key, node.value]) }
    entry_list
  end

  private

  def increase_capacity
    old_buckets = @buckets
    @capacity *= 2
    @buckets = Array.new(@capacity)

    loop_nodes(old_buckets) { |node| set(node.key, node.value) }
  end

  def overloaded?
    in_use = @buckets.count { |element| !element.nil? }

    in_use.to_f / @capacity > LOAD_FACTOR
  end

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

  def loop_nodes(buckets = @buckets)
    buckets.each do |bucket|
      next if bucket.nil?

      node = bucket.head
      until node.nil?
        yield(node)
        node = node.next_node
      end
    end
  end
end
