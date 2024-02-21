# frozen_string_literal: true

require_relative 'lib/hash_map'

map = HashMap.new
map.set('foo', 'bar')
puts map.get('foo')
