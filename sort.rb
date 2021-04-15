# @author InterPegasus

def sort_array(nums)
    if nums.length > 50000
        return nums
    end
    time1 = Time.now
    result = merge_sort(nums)
    puts "Total Time: #{Time.now - time1}"
    result
end

def ruby_sort(nums)
    nums.sort
end

def selection_sort(nums)
    counter = 0
    while counter < nums.length do
        inner_counter = counter + 1
        minimum = counter        
        while inner_counter < nums.length do             
            if nums[minimum] > nums[inner_counter]
                minimum = inner_counter
            end
            inner_counter = inner_counter + 1
        end
        if minimum != counter
            temp = nums[counter]
            nums[counter] = nums[minimum]
            nums[minimum] = temp
        end
        counter = counter + 1
    end
    nums
end


def insertion_sort(nums)
    counter = 0
    while counter < nums.length do
        inner_counter = 1
        while inner_counter < nums.length do
            if nums[inner_counter] < nums[inner_counter - 1]
                temp = nums[inner_counter - 1]
                nums[inner_counter - 1] = nums[inner_counter]
                nums[inner_counter] = temp
            end
            inner_counter = inner_counter + 1
        end 
        counter = counter + 1
    end
    nums
end

def merge_sort(nums)
    if nums.length <= 1
        return nums
    end
    middle = (nums.length / 2).floor
    left_array = nums.slice(0, middle)
    right_array = nums.slice(middle, nums.length - middle)    
    merge_arrays(merge_sort(left_array),merge_sort(right_array))    
end

def merge_arrays(left,right)
    sorted_output = []
    while left.length > 0 && right.length > 0 do
        if left[0] <= right[0]
            sorted_output.push(left.shift)
        else       
            sorted_output.push(right.shift)
        end
    end
    sorted_output.concat(left).concat(right)
end

def merge_arrays_and_count(left_arr, right_arr)
    inversions = 0
    sorted_output = []
    i,j = 0,0
    while i < left_arr.length and j < right_arr.length
        if left_arr[i] < right_arr[j]
            sorted_output << left_arr[i]
            i+=1
        else
            sorted_output << right_arr[j]
            j+=1
            inversions += left_arr.length - i
        end
    end

    if i < left_arr.length
        sorted_output += left_arr[i..(left_arr.length - 1)]
    else
        sorted_output += right_arr[j..(right_arr.length - 1)]
    end

    return [inversions, sorted_output]
end


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

def choose_pivot(nums,left,right,pivot_id)
    if pivot_id == 'first'        
    elsif pivot_id == 'last'        
        (nums[left], nums[right]) = [nums[right], nums[left]]
    elsif pivot_id == 'middle'        
        mid = ((right - left)/2).floor + left
        middle_array = [nums[left], nums[right], nums[mid]]
        middle_array = middle_array.sort
        if middle_array[1] == nums[left]
            pivot_index = left
        elsif middle_array[1] == nums[right]
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
    [*(left+1)..right].each do |right_mark|
        if nums[right_mark] < pivot_value
            (nums[left_mark],nums[right_mark]) = [nums[right_mark],nums[left_mark]]
            left_mark = left_mark + 1
        end
    end
    (nums[left_mark-1],nums[left]) = [nums[left],nums[left_mark-1]]
    left_mark - 1       # partition point := where pivot finally occupies
end
    
    
    
def quickSort(nums,left,right,pivot_id)
    total_comparissons = right - left
    if right <= left
        return [nums, 0]
    else
        choose_pivot(nums,left,right,pivot_id)
        splitpoint = partition(nums,left,right)
        (left_sorted,total_comparissons_left) = quickSort(nums, left, splitpoint - 1, pivot_id)
        (right_sorted,total_comparissons_right) = quickSort(nums, splitpoint + 1 , right, pivot_id)
        total_comparissons =  total_comparissons + total_comparissons_left + total_comparissons_right
    end
    return [nums, total_comparissons]
end

  # Swap the leftest "right" value with the pivot
  array[right] = array[dividing_index]
  array[dividing_index] = pivot
  dividing_index
end

