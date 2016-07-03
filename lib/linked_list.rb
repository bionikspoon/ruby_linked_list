module Linked
  class List
    def initialize items=[]
      items.each { |item| self.append item }
    end

    def each
      return enum_for :each unless block_given?

      self.each_node { |node| yield node.value }
    end

    def to_a
      self.each.to_a
    end

    def append value
      self.tail = value
      self
    end

    def prepend value
      self.head = value
      self
    end

    def size
      self.nodes.size
    end

    def head
      @head.value unless @head === nil
    end

    def tail
      @tail.value unless @head === nil
    end

    def at index
      self.each_node.with_index { |item, i| return item.value if i == index }
    end

    def pop
      tail = @tail
      self.each_node do |node|
        next unless node.next_node === @tail
        @tail = node
        @tail.next_node = nil
        break
      end
      @head = nil if tail === @head
      tail.value
    end

    def contains? *args
      self.to_a.include? *args
    end

    def find *args
      self.each.find_index *args
    end

    def to_s
      return 'nil' if @head === nil
      "#{self.nodes.join(' -> ')} -> nil"
    end

    def insert_at index, value
      return self.prepend value if index == 0

      self.each_node.with_index do |node, i|
        next unless i == index - 1
        return self.append value if node === @tail

        next_node = Node.new value, node.next_node
        node.next_node = next_node
        break
      end
      self
    end

    def remove_at index
      (self.shift; return self) if index == 0

      self.each_node.with_index do |node, i|
        next unless i == index - 1
        (self.pop; return self) if node.next_node === @tail

        node.next_node = node.next_node.next_node

        break
      end
      self
    end

    protected

    def each_node
      return enum_for :each_node unless block_given?

      node = @head
      until node === nil
        yield node
        node = node.next_node
      end
    end

    def nodes
      self.each_node.to_a
    end

    def shift
      @head, head = @head.next_node, @head
      head
    end

    def head= value
      @head = Node.new value, @head
      @tail = @head if @head.next_node === nil
      self
    end

    def tail= value
      return self.head = value if @tail === nil

      @tail.next_node = Node.new value
      @tail = @tail.next_node
    end
  end

  class Node
    attr_accessor :value, :next_node

    def initialize value=nil, next_node=nil
      @value = value
      @next_node = next_node
    end

    def to_s
      "( #{@value.to_s} )"
    end
  end
end
