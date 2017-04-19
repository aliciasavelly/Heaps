require_relative "heap"

class Array
  def heap_sort!
    full_length = self.length
    length = 0

    until length == full_length
      length += 1
      self[0..length] = BinaryMinHeap.heapify_up(self[0..length], length - 1, length) { |num1, num2| -1 * (num1 <=> num2) }
    end
    # we now have full max heap so can continue to sort now

    place = -1
    until length == 0
      first = self[0]
      last = self[place]
      self[0] = last
      self[place] = first
      length -= 1
      self[0...length] = BinaryMinHeap.heapify_down(self[0...length], 0, length) { |num1, num2| -1 * (num1 <=> num2) }
      place -= 1
    end

    self
  end
end
