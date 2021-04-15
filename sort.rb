def quick_sort(array)
  if array.length > 1
    pivot_index = (array.length/2).floor
    pivot = array.delete_at(pivot_index)
    left, right = [], []
    array.each do |value|
      value <= pivot ? left.push(value) : right.push(value)
    end
    array = quick_sort(left).concat([pivot]).concat(quick_sort(right))
  end
  array
end

def quick_sort_in_place(array, left = 0, right = array.length - 1)
  if right > left
    pivot = partition(array, left, right)
    quick_sort_in_place(array, left, pivot - 1)
    quick_sort_in_place(array, pivot + 1, right)
  end
  array
end

def partition(array, left, right)
  pivot = array[right]
  # Choosing a good pivot
  random_pivot_index = Random.rand(array.length)
  array[right] = array[random_pivot_index]
  array[random_pivot_index] = pivot
  pivot = array[right]

  dividing_index = left
  (left...right).each do |index|
    value = array[index]
    if value <= pivot
      # Swap the value into the "left" partition, and increment the dividing_index
      array[index] = array[dividing_index]
      array[dividing_index] = value
      dividing_index += 1
    end
  end
  # Swap the leftest "right" value with the pivot
  array[right] = array[dividing_index]
  array[dividing_index] = pivot
  dividing_index
end