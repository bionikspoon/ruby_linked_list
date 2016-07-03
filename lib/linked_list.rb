module Linked
  class List
    def append
    end

    def prepend
    end

    def size
    end

    def head
    end

    def tail
    end

    def at index
    end

    def pop
    end

    def contains?
    end

    def find data
    end

    def to_s
    end

    def insert_at index
    end

    def remove_at index
    end
  end

  class Node
    attr_accessor :value, :next_node

    def initialize value=nil, next_node=nil
      @value = value
      @next_node = next_node
    end
  end
end
