module Linked
  class List
    def initialize(items=[])
      items.each { |item| self.append item }
    end

    def append(value)
      # Guard, empty list
      return self.prepend value if self.empty?

      @tail.next_node = Node.new value # tail points to new node
      @tail = @tail.next_node # new node set to tail
      self
    end

    def prepend(value)
      @head = Node.new value, next_node: @head # head becomes next_node to new head
      @tail ||= @head # make sure tail is set
      self
    end

    def size
      self.nodes.size # self.nodes == self.each_node.to_a
    end

    def head
      @head.value unless @head === nil
    end

    def tail
      @tail.value unless @head === nil
    end

    def at(index)
      node, _ =self.each.with_index.find { |_, i| i == index }
      node
    end

    def pop
      # Guard, 1 item
      return self.shift if @head === @tail

      tail = @tail
      self.each_node { |node| break @tail = node.update_next_node if node.next_node === @tail }

      tail.value
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
      return self.prepend value if index === 0

      # Get node at index
      node, _ = self.each_node.with_index.find { |_, i| i == index - 1 }
      # Guard, node not found
      return self unless node
      # Guard, use append for last value
      return self.append value if node === @tail

      # node points to new node that points to next node
      node.next_node = Node.new value, next_node: node.next_node
      self
    end

    def remove_at(index)
      # Guard, use shift
      (self.shift; return self) if index == 0

      # Get node before index
      node, _ = self.each_node.with_index.find { |_, i| i == index - 1 }
      # Guard, node not found
      return self unless node
      # Guard, use pop for last node
      (self.pop; return self) if node.next_node === @tail

      # node points to NEXT NEXT node
      node.next_node = node.next_node.next_node
      self
    end

    # iterate node values
    def each
      # Guard, return enumerator
      return enum_for :each unless block_given?

      self.each_node { |node| yield node.value }
    end

    def to_a
      self.each.to_a
    end

    def empty?
      @head === nil or @tail === nil
    end

    protected

    # iterate each node
    def each_node
      # Guard, return enumerator
      return enum_for :each_node unless block_given?

      # yield each node
      node = @head
      until node === nil
        yield node
        node = node.next_node
      end
    end

    def nodes #ruby convention
      self.each_node.to_a
    end


  end

  class Node
    attr_accessor :value, :next_node

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
  end
end
