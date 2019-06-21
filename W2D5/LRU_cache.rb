class LRUCache
    def initialize(size)        # takes in integer, refering to size of cache
        @size = size            # initialize attribute
        @cache = []             # initialize attribute to equal array (this will contain other simple data types)
    end

    def count                   # returns number of elements currently in cache
        cache.size
    end

    def add(el)                 # adds element to cache according to LRU principle
        if cache.include?(el)   # if el is in cache, delete it, but then add el to "end" of cache array
            cache.delete(el)
            cache << el
        elsif count >= size     # if el is not in cache, delete 1st ele of cache arr, then add el to end of cache arr
            cache.shift
            cache << el
        else                    # otherwise just add el to end of cache arr
            cache << el
        end
    end                         # returns updated cache

    def show                    # shows the items in the cache, with the LRU item first
      p cache
    end

    private                     # helper methods go here!
    attr_accessor :cache, :size
end


p cash_monies = LRUCache.new(4)         #=> #<LRUCache:0x00007f9ac0090440 @size=4, @cache=[]>
p cash_monies.add("I walk the line")    #=> ["I walk the line"]     
p cash_monies.add(5)                    #=> ["I walk the line", 5]     
p cash_monies.count                     #=> returns 2