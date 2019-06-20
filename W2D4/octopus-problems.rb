# 1) Find the longest string in this array with an algo in O(n^2) time
fish = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']
def n_squared_search(arr)
    longest = ''
    (0...arr.length - 1).each do |i|            # 2x nested loop (dependent on arr length) => quadratic time
        (i + 1...arr.length).each do |j|
            str1 = arr[i]                   
            str2 = arr[j]
            if str1.length > str2.length
                longest = str1
            elsif str2.length > str1.length
                longest = str2
            end
        end
    end
    longest
end
# p n_squared_search(fish)       #=> "fiiiissshhhhhh"



# 2) Find the longest string in this array with an algo in O(n log n) time
fish = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']
# sort array using merge sort (uses n log n)
# then grab last element (1)
# total time: => nlogn + 1 => nlogn
def merge_sort(arr)                 # sorts ascending
    return arr if arr.size <=1
    mid_idx = arr.size/2
    left = arr.take(mid_idx)
    right = arr.drop(mid_idx)
    merge(merge_sort(left), merge_sort(right))
end
def merge(left, right)
    merged = []
    until left.empty? || right.empty?
        if left.first.length > right.first.length
            merged << right.shift
        else
            merged << left.shift
        end
    end
    merged + left + right
end
def n_log_n_search(arr)
    sorted = merge_sort(arr)    # Time Complexity: nlogn
    sorted[-1]                  # Time Complexity: 1
end                             # Total Time: nlogn
# p n_log_n_search(fish)        #=> "fiiiissshhhhhh"




# 3) lognest fish in O(n) Time
def o_of_n_search(arr)
    longest = ""
    arr.each do |str|
        if str.length >= longest.length
            longest = str
        end
    end
    longest
end
# p o_of_n_search(fish)   #=> "fiiiissshhhhhh"



# 4) O(n) slow dance
tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]
def slow_dance(move, arr)
    arr.each_with_index { |e,i| return i if e == move }
end
# p slow_dance("up", tiles_array)           #=> 0
# p slow_dance("right-down", tiles_array)   #=> 3




# 5) O(1) Constant dance!
tiles_hash = { "up"=>0, "right-up"=>1, "right"=>2, "right-down"=>3, "down"=>4, "left-down"=>5, "left"=>6,  "left-up"=>7 }
def slow_dance(move, arr)
    arr[move]
end
# p slow_dance("up", tiles_hash)            #=> 0
# p slow_dance("right-down", tiles_hash)    #=> 3