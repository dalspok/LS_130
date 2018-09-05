def reduce(array, start=nil)
  return array[0] if array.size == 1
  counter = start.nil? ? 1 : 0
  acc = start.nil? ? array[0] : start
  while counter < array.size
    acc = yield(acc, array[counter])
    counter += 1
  end
  acc
end

array = [1, 2, 3, 4, 5]

p reduce(array) { |acc, num| acc + num }                    # => 15
p reduce(array, 10) { |acc, num| acc + num }                # => 25
# p reduce(array) { |acc, num| acc + num if num.odd? }        # => NoMethodError: undefined method `+' for nil:NilClass
p reduce(['a', 'b', 'c']) { |acc, value| acc += value }