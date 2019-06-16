class Stack                 # LIFO- last in first out
    attr_accessor :stack

    def initialize          # create ivar to store stack here!
      @stack = []
    end

    def push(el)            # adds an element to the stack
      # self.push(el)       # be careful, you're calling .push on the stack class -> "stack level too deep!"
      # @stack << el        # works
      # @stack.push(el)     # works
      stack.push(el)        # returns modified stack array
    end

    def pop                 # removes one element from the stack
      stack.pop             # returns deleted last ele from stack array
    end

    def peek                # returns, but doesn't remove, the top element in the stack
      stack.last
    end
end

# mystack = Stack.new
# p mystack.push('potato')
# p mystack.push('lambas bread')
# p mystack.push('apples')
# p mystack.peek                      #=> 'apples'
# p mystack.pop                       #=> 'apples'
# p mystack




class Queue                     # FIFO- first in first out
    attr_accessor :queue

    def initialize
        @queue = []
    end

    def enqueue(el)
        self.queue.push(el)     # adds ele to End of queue
        # queue.push(el)        # works also
    end

    def dequeue
        self.queue.shift        # deletes First ele from queue array
    end

    def peek
        self.queue.last         # returns Last ele from queue array?
    end
end


require "byebug"
class Map                       # ex. my_map = [[k1, v1], [k2, v2], [k3, v2], ...]
    attr_accessor :map

    def initialize
        @map_adt = []
    end

    def set(key, value)                   # can be used to either create a new k-v pair, or update the val for pre-existing key
        # MY solution below:
        map_adt.each.with_index do |k_v_pair, i|[1]       # search through each ele in map array
            if i == map_adt.size - 1    # if we're on last ele 
              map_adt.push([key, value])
            elsif k == k_v_pair[0]      # if we find matching key
                k_v_pair[1] = value     # reassign value
            end
        end 
        # AA- Solution below:
        # pair_idx = map_adt.index { |pair| pair[0] == key }       # pair_idx will be undefined if arg key not in map obj array
        # if pair_idx                        # if pair_idx is NOT undefined/nil (nil's are "falsey")
        #     map_adt[pair_idx][1] = value
        # else                               # if pair_idx IS NIL/undefined
        #     map_adt.push([key, value])     # just push new k/v pair (as an array) to map array
        # end
        # value                              # why return the value? (guess we don't want to expose/show the new modified array?)
    end

    def get(key)                           # returns value at corresponding key
        # map_adt.each do |pair|
        #     return pair[1] if pair[0] == key
        # end
        map_adt.each { |pair| return pair[1] if pair[0] == key }
    end

    def delete(key)                       # deletes k-v pair at corresponding key
        map_adt.reject! { |pair| pair[0] == key }
    end

    def show                             # display map array
        map_adt
    end
end

my_map = Map.new                # []
p my_map.set('potatoes', 3)     #=> [['potatoes', 3]]
p my_map.set('potatoes', 4)     #=> [['potatoes', 4]]
