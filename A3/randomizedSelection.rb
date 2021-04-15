def file_to_array(file_path = "/Users/arturo/Downloads/Stanford/A2/QuickSort.txt")
    output = []
    File.readlines(file_path).each do |i|
        output.push(i.to_i)
    end
    output
end

def test            
    nums = file_to_array
    search_ith = rand(nums.length)
    nums_sorted = nums.sort
    output = linearRandomSearch(nums, 0, nums.length - 1, search_ith)
    puts "Test Result searching for the #{search_ith}th element: #{nums_sorted[search_ith] == output}" 
end 
    
def choose_random_pivot(nums,left,right)
    pivot_index = rand(left..right)
    (nums[left], nums[pivot_index]) = [nums[pivot_index], nums[left]]
end
    
def partition(nums, left, right)
    pivot_value = nums[left]
    left_mark = left + 1
    [*(left + 1)..right].each do |right_mark|
        if nums[right_mark] < pivot_value
            (nums[left_mark],nums[right_mark]) = [nums[right_mark],nums[left_mark]]
            left_mark = left_mark + 1
        end
    end
    (nums[left_mark - 1],nums[left]) = [nums[left],nums[left_mark - 1]]
    left_mark - 1 # partition point -> where pivot finally located
end
    
    
# search_ith
def linearRandomSearch(nums,left,right,search_ith)
    if nums.length == 1
        return nums[0]
    else
        choose_random_pivot(nums,left,right)
        splitpoint = partition(nums,left,right)
        if splitpoint == search_ith
            return nums[splitpoint]
        elsif splitpoint > search_ith
            linearRandomSearch(nums, left, splitpoint - 1, search_ith)            
        elsif splitpoint < search_ith
            linearRandomSearch(nums, splitpoint + 1 , right, search_ith)            
        end                      
    end
end
    