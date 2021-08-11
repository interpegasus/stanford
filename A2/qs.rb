def file_to_array(file_path = "/Users/arturo/Downloads/Stanford/A2/QuickSort.txt")
  output = []
  File.readlines(file_path).each do |i|
    output.push(i.to_i)
  end
  output
end

def test
  ["first", "middle", "last"].each_with_index do |pivot_id, index|
    nums = file_to_array
    (sorted_output, number_comparissons) = quickSort(nums, 0, nums.length - 1, pivot_id)
    puts "#{index + 1}. Test Pass: #{sorted_output == nums.shuffle.sort} Number Comparissons #{pivot_id} pivot: #{number_comparissons}"
  end
end

def choose_pivot(nums, left, right, pivot_id)
  if pivot_id == "first"
  elsif pivot_id == "last"
    (nums[left], nums[right]) = [nums[right], nums[left]]
  elsif pivot_id == "middle"
    mid = ((right - left) / 2).floor + left
    listTemp = [nums[left], nums[right], nums[mid]]
    listTemp.sort()
    if listTemp[1] == nums[left]
      pivot_index = left
    elsif listTemp[1] == nums[right]
      pivot_index = right
    else
      pivot_index = mid
    end
    (nums[left], nums[pivot_index]) = [nums[pivot_index], nums[left]]
  end
end

def partition(nums, left, right)
  pivot_value = nums[left] # initialise pivot as the first element
  left_mark = left + 1
  [*(left + 1)..right].each do |right_mark|
    if nums[right_mark] < pivot_value
      (nums[left_mark], nums[right_mark]) = [nums[right_mark], nums[left_mark]]
      left_mark = left_mark + 1
    end
  end
  (nums[left_mark - 1], nums[left]) = [nums[left], nums[left_mark - 1]]
  left_mark - 1       # partition point := where pivot finally occupies
end

def quickSort(nums, left, right, pivot_id)
  total_comparissons = right - left
  if right <= left
    return [nums, 0]
  else
    choose_pivot(nums, left, right, pivot_id)
    splitpoint = partition(nums, left, right)
    (left_sorted, total_comparissons_left) = quickSort(nums, left, splitpoint - 1, pivot_id)
    (right_sorted, total_comparissons_right) = quickSort(nums, splitpoint + 1, right, pivot_id)
    total_comparissons = total_comparissons + total_comparissons_left + total_comparissons_right
  end
  return [nums, total_comparissons]
end
