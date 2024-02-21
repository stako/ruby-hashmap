# frozen_string_literal: true

require_relative 'lib/hash_map'
require_relative 'lib/linked_list'

map = HashMap.new
map.set('foo', 'bar')
puts map.get('foo')
puts map.has('foo')
puts map.has('baz')
