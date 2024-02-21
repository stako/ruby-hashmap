# frozen_string_literal: true

# Personal hash map implementation
class HashMap
  def initialize
    @capacity = 16
    @load_factor = 0.75
    @buckets = Array.new(@capacity)
  end

  def set(key, value)
    @buckets[get_index(key)] = Node.new(key, value)
  end

  def get(key)
    @buckets[get_index(key)].value
  end

  def has(key)
    index = get_index(key)

    @buckets[index] and @buckets[index].key == key or false
  end

  def length
    @buckets.count { |element| !element.nil? }
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
