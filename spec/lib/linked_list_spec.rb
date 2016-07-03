require 'spec_helper'
require 'linked_list'
include Linked

describe Linked::List do
  before :each do
    @empty_list = List.new
  end

  describe "#append" do
    it "should exist" do
      @empty_list.respond_to?(:append).should be true
    end
  end

  describe "#prepend" do
    it "should exist" do
      @empty_list.respond_to?(:prepend).should be true
    end
  end

  describe "#size" do
    it "should exist" do
      @empty_list.respond_to?(:size).should be true
    end
  end

  describe "#head" do
    it "should exist" do
      @empty_list.respond_to?(:head).should be true
    end
  end

  describe "#tail" do
    it "should exist" do
      @empty_list.respond_to?(:tail).should be true
    end
  end

  describe "#at" do
    it "should exist" do
      @empty_list.respond_to?(:at).should be true
    end
  end

  describe "#pop" do
    it "should exist" do
      @empty_list.respond_to?(:pop).should be true
    end
  end

  describe "#contains?" do
    it "should exist" do
      @empty_list.respond_to?(:contains?).should be true
    end
  end

  describe "#find" do
    it "should exist" do
      @empty_list.respond_to?(:find).should be true
    end
  end

  describe "#to_s" do
    it "should exist" do
      @empty_list.respond_to?(:to_s).should be true
    end
  end

  xdescribe "#insert_at" do
    it "should exist" do
      @empty_list.respond_to?(:insert_at).should be true
    end
  end

  xdescribe "#remove_at" do
    it "should exist" do
      @empty_list.respond_to?(:remove_at).should be true
    end
  end

end

describe Linked::Node do

  it 'should have initial value of nil' do
    node = Node.new
    node.value.should equal nil
  end

  it 'should have initial next_node value of nil' do
    node = Node.new
    node.next_node.should equal nil
  end
end