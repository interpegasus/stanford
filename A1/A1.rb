# Stanford: Algorithms: Design and Analysis, Part 1 A1
def count_inversions
  nums = file_to_array
  output = merge_sort_inv(nums)
  output[0]
end

def merge_sort_inv(nums)
  if nums.length <= 1
    return [0, nums]
  end
  middle = (nums.length / 2).floor
  left = merge_sort_inv(nums.slice(0, middle))
  right = merge_sort_inv(nums.slice(middle, nums.length - middle))
  merge_result = merge_arrays_inv(left[1], right[1])
  return [left[0].to_i + right[0].to_i + merge_result[0].to_i, merge_result[1]]
end

def merge_arrays_inv(left, right)
  output = []
  inversions = 0
  while left.to_a.length > 0 && right.to_a.length > 0
    if left[0] <= right[0]
      output.push(left.shift)
    else
      output.push(right.shift)
      inversions = inversions + left.length
    end
  end
  return [inversions, output.concat(left.to_a).concat(right.to_a)]
end

def file_to_array(file_path = "/Users/arturo/Downloads/Stanford/A1/IntegerArray.txt")
  output = []
  File.readlines(file_path).each do |i|
    output.push(i.to_i)
  end
  output
end

def test
  count_inversions == 2407905288
end
