class BinaryMinHeap
  def initialize(&prc)
    @prc = prc
    @store = []
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    result = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, @store.length)
    result
  end

  def peek
    @store[0]
  end

  def push(val)
    @store << val
    BinaryMinHeap.heapify_up(@store, @store.length - 1, @store.length)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    child_indices = []
    child_indices << 2 * parent_index + 1 if 2 * parent_index + 1 < len
    child_indices << 2 * parent_index + 2 if 2 * parent_index + 2 < len

    child_indices
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |num1, num2| num1 <=> num2 }
    p_idx = parent_idx
    min_child_idx = BinaryMinHeap.child_indices(len, p_idx)

    if min_child_idx == []
      min_child_idx = []
    elsif min_child_idx.length == 1
      min_child_idx = min_child_idx[0]
    elsif prc.call(array[min_child_idx[0]], array[min_child_idx[1]]) == -1
      min_child_idx = min_child_idx[0]
    elsif min_child_idx != []
      min_child_idx = min_child_idx[1]
    end

    until min_child_idx == [] || prc.call(array[p_idx], array[min_child_idx]) == -1 || prc.call(array[p_idx], array[min_child_idx]) == 0
      child = array[min_child_idx]
      parent = array[p_idx]

      array[min_child_idx] = parent
      array[p_idx] = child

      p_idx = min_child_idx
      min_child_idx = BinaryMinHeap.child_indices(len, p_idx)

      if min_child_idx == []
        min_child_idx = []
      elsif min_child_idx.length == 1
        min_child_idx = min_child_idx[0]
      elsif prc.call(array[min_child_idx[0]], array[min_child_idx[1]]) == -1
        min_child_idx = min_child_idx[0]
      elsif min_child_idx != []
        min_child_idx = min_child_idx[1]
      end

    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return array if child_idx == 0
    prc ||= Proc.new { |num1, num2| num1 <=> num2 }
    parent_idx = BinaryMinHeap.parent_index(child_idx)
    prc_call = prc.call(array[child_idx], array[parent_idx])

    while prc_call == -1
      array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]

      child_idx = parent_idx
      return array if child_idx == 0
      parent_idx = BinaryMinHeap.parent_index(child_idx)
      prc_call = prc.call(array[child_idx], array[parent_idx])
    end

    array
  end
end
