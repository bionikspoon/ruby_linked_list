require 'spec_helper'
require 'linked_list'
include Linked

describe Linked::List do
  before :each do
    @empty_list = List.new
    @list = List.new (1..5)
  end

  describe '#initialize' do
    it 'should exist' do
      @empty_list.should be_instance_of List
    end
    it 'should initialize with an optional list' do
      @list.head.should eq 1
      @list.tail.should eq 5
    end
  end

  describe '#append' do
    it 'should exist' do
      @empty_list.respond_to?(:append).should be true
    end

    it 'should add item to end of list when list is empty' do
      @empty_list.append 1
      @empty_list.head.should eq 1
      @empty_list.tail.should eq 1
    end

    it 'should add item to end of list when list is not empty' do
      @empty_list.append(1).append(2).append(3)
      @empty_list.head.should eq 1
      @empty_list.tail.should eq 3
    end

  end

  describe '#prepend' do
    it 'should exist' do
      @empty_list.respond_to?(:prepend).should be true
    end

    it 'should add a node to the head position when head is nil' do
      @empty_list.prepend(1)
      @empty_list.head.should eq 1
      @empty_list.tail.should eq 1
    end

    it 'should add a node to the head position when head has a value' do
      @empty_list.prepend(1).prepend(2).prepend(3)

      @empty_list.head.should eq 3
      @empty_list.tail.should eq 1
    end
  end

  describe '#size' do
    it 'should exist' do
      @empty_list.respond_to?(:size).should be true
    end

    it 'should get empty list size' do
      @empty_list.size.should eq 0
    end

    it 'should get  list size' do
      puts @list.size
      @list.size.should eq 5
    end
  end

  describe '#head' do
    it 'should exist' do
      @empty_list.respond_to?(:head).should be true
    end

    it 'should initially be nil' do
      @empty_list.head.should be_nil
    end
  end

  describe '#tail' do
    it 'should exist' do
      @empty_list.respond_to?(:tail).should be true
    end
    it 'should initially be nil' do
      @empty_list.tail.should be_nil
    end

    it 'should be first element when item is added' do
      @empty_list.prepend(1).tail.should eq 1
    end
  end

  describe '#at' do
    it 'should exist' do
      @empty_list.respond_to?(:at).should be true
    end

    it 'should return item at index 0' do
      @list.at(0).should eq 1
    end
    it 'should return item at index 3' do
      @list.at(3).should eq 4
    end
    it 'should return item at index 4' do
      @list.at(4).should eq 5
    end
  end

  describe '#pop' do
    it 'should exist' do
      @empty_list.respond_to?(:pop).should be true
    end

    it 'should return and remove last item from the list' do
      item = @list.pop
      item.should eq 5
      @list.tail.should eq 4
    end

    it 'should pop several and still work' do
      @list.pop
      @list.pop
      @list.pop

      @list.tail.should eq 2
      @list.to_a.should eq [1, 2]
    end

    it 'should set head and tail to nil if last item' do
      list = List.new [1]
      list.pop

      list.head.should be_nil
      list.tail.should be_nil
    end
  end

  describe '#contains?' do
    it 'should exist' do
      @empty_list.respond_to?(:contains?).should be true
    end

    it 'should work on empty list' do
      @empty_list.contains?(4).should be false
    end

    it 'should return true if list contains value' do
      @list.contains?(5).should be true
    end

    it 'should return false if list does not contain value' do
      @list.contains?(6).should be false
    end
  end

  describe '#find' do
    it 'should exist' do
      @empty_list.respond_to?(:find).should be true
    end

    it 'should find the index for a value' do
      list = List.new %w[cat dog rabbit fish]
      list.find('rabbit').should eq 2
    end

    it 'should return nil for an empty list' do
      @empty_list.find('rabbit').should be_nil
    end
  end

  describe '#to_s' do
    it 'should exist' do
      @empty_list.respond_to?(:to_s).should be true
    end
    it 'should format values to a string' do
      list = List.new %w[cat dog rabbit fish]
      list.to_s.should eq '( cat ) -> ( dog ) -> ( rabbit ) -> ( fish ) -> nil'
    end

    it 'should return "nil" for an empty list' do
      @empty_list.to_s.should eq 'nil'
    end
  end

  describe '#insert_at' do
    it 'should exist' do
      @empty_list.respond_to?(:insert_at).should be true
    end

    it 'should insert value at index 0' do
      @list.insert_at(0, 'data').to_a.should eq ['data', 1, 2, 3, 4, 5]
    end

    it 'should insert value at last index' do
      @list.insert_at(5, 'data')
      @list.to_a.should eq [1, 2, 3, 4, 5, 'data']
      @list.tail.should eq 'data'
    end

    it 'should insert value at any index' do
      @list.insert_at(2, 'data').to_a.should eq [1, 2, 'data', 3, 4, 5]
    end

    it 'should do nothing if index is out of range' do
      @list.insert_at(40, 'data').to_a.should eq [1, 2, 3, 4, 5]
    end

    it 'should do nothing if index is out of range with empty_list' do
      @empty_list.insert_at(40, 'data').to_a.should eq []
    end
  end

  describe '#remove_at' do
    it 'should exist' do
      @empty_list.respond_to?(:remove_at).should be true
    end

    it 'should remove value at index 0' do
      @list.remove_at(0).to_a.should eq [2, 3, 4, 5]
    end

    it 'should remove value at last index' do
      @list.remove_at(4).to_a.should eq [1, 2, 3, 4]
    end

    it 'should remove value at second to last index' do # potential edge
      @list.remove_at(3).to_a.should eq [1, 2, 3, 5]
    end

    it 'should remove value at any index' do
      @list.remove_at(2).to_a.should eq [1, 2, 4, 5]
    end

    it 'should should do nothing of index is out of range' do
      @list.remove_at(40).to_a.should eq [1, 2, 3, 4, 5]
    end

    it 'should should do nothing of index is out of range with empty_list' do
      @empty_list.remove_at(40).to_a.should eq []
    end

    it 'should set head and tail to nil when removing last value' do
      list = List.new [1]
      list.remove_at(0)

      list.head.should be_nil
      list.tail.should be_nil
      list.to_a.should eq []
    end
  end

  describe '#each' do
    it 'should exist' do
      @empty_list.respond_to?(:each).should be true
    end

    it 'should be an Enumerator' do
      @list.each.should be_instance_of Enumerator
    end

    it 'should work like an enumerable' do
      enum = @list.each
      enum.next.should eq 1
      enum.next.should eq 2
      enum.next.should eq 3
    end

    it 'should worth with to_a' do
      @list.each.to_a.should eq [1, 2, 3, 4, 5]
    end

    it 'should work with code block' do
      items = []
      @list.each { |n| items << n }

      items.should eq [1, 2, 3, 4, 5]
    end
  end

  describe '#to_a' do
    it 'should exist' do
      @empty_list.respond_to?(:to_a).should be true
    end

    it 'should return an array of items' do
      @list.to_a.should eq [1, 2, 3, 4, 5]
    end
  end
end

describe Linked::Node do
  describe '#initialize' do
    before(:each) do
      @node = Node.new
    end
    it 'should have initial value of nil' do
      @node.value.should equal nil
    end

    it 'should have initial next_node value of nil' do
      @node.next_node.should equal nil
    end
  end

  describe '#to_s' do
    before(:each) do
    end

    it 'should return its value' do
      node = Node.new 10
      node.to_s.should eq '( 10 )'
    end
  end
end