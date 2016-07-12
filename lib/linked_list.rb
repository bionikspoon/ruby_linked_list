module Linked
  class List
    include Enumerable

    def initialize(items=[])
      items.each { |item| self.append item }
    end

    def append(value)
      # Guard, empty list
      return prepend value if empty?

      tail_node.next_node = Node.new value
      self
    end

    def prepend(value)
      @head = Node.new value, next_node: @head
      self
    end

    def size
      self.nodes.size # self.nodes == self.each_node.to_a
    end

    def head
      @head.value unless empty?
    end

    def tail
      node = tail_node
      node.value if node
    end

    def tail_node
      self.each_node.find { |node| node.next_node.nil? }
    end

    def at(index)
      node = at_node(index)
      node.value if node
    end

    def at_node(index)
      node, _ =self.each_node.with_index.find { |_, i| i == index }
      node
    end

    def pop
      # Guard, 0 items
      return @head if empty?
      # Guard, 1 item
      return shift if @head.next_node.nil?

      left = nil
      self.each_node do |right|
        if right.next_node.nil?
          left.next_node = right.next_node
          return right.value
        end
        left = right
      end
    end

    def shift
      @head, head = @head.next_node, @head # @head becomes @head.next_node
      head
    end

    def contains?(*args)
      self.each.include? *args
    end

    def find(*args)
      self.each.find_index *args
    end

    def to_s
      self.empty? ? 'nil' : "#{self.nodes.join(' -> ')} -> nil"
    end

    def insert_at(index, value)
      # Guard, use prepend
      return prepend value if index === 0

      # Get node at index
      left = at_node(index -1)
      # Guard, node not found
      return self unless left

      # node points to new node that points to next node
      left.next_node = Node.new value, next_node: left.next_node
      self
    end

    def remove_at(index)
      # Guard, use shift
      (self.shift; return self) if index == 0

      # Get node before index
      left = at_node(index-1)
      # Guard, node not found
      return self unless left
      # Guard, use pop for last node
      (self.pop; return self) if left.next_node.nil?

      # node points to NEXT NEXT node
      left.next_node = left.next_node.next_node
      self
    end

    # iterate node values
    def each
      # Guard, return enumerator
      return enum_for :each unless block_given?

      self.each_node { |node| yield node.value }
    end

    # iterate each node
    def each_node
      # Guard, return enumerator
      return enum_for :each_node unless block_given?

      # yield each node
      node = @head
      until node.nil?
        yield node
        node = node.next_node
      end
    end

    def nodes #ruby convention
      self.each_node.to_a
    end

    def to_a
      self.each.to_a
    end

    def empty?
      @head.nil?
    end


  end

  class Node
    attr_accessor :value, :next_node
    include Comparable

    def initialize(value=nil, next_node: nil)
      @value = value
      @next_node = next_node
    end

    def to_s
      "( #{@value.to_s} )"
    end

    # helper method to chain updates and return
    def update_next_node(value = nil)
      @next_node = value
      self
    end

    def <=>(other)
      return -1 if other.nil?
      self.value <=> other.value
    end
  end
end
