# Ruby Linked List

From [The Odin Project](http://www.theodinproject.com/ruby-programming/linked-lists)

## Your Task
You will need two classes:

1. `Linked::List` class, which will represent the full list.
2. `Linked::Node` class, containing a `#value` method and a link to the `#next_node`, set both as `nil` by default.


Build the following methods in your linked list class:

1. `#append` adds a new node to the end of the list
2. `#prepend` adds a new node to the start of the list
3. `#size` returns the total number of nodes in the list
4. `#head` returns the first node in the list
5. `#tail` returns the last node in the list
6. `#at(index)` returns the node at the given index
7. `#pop` removes the last element from the list
8. `#contains?` returns true if the passed in value is in the list and otherwise returns false.
9. `#find(data)` returns the index of the node containing data, or nil if not found.
10. `#to_s` represent your LinkedList objects as strings, so you can print them out and preview them in the console.
  The format should be: `( data ) -> ( data ) -> ( data ) -> nil`

### Extra Credit

1. `#insert_at(index)` that inserts the data at the given index
2. `#remove_at(index)` that removes the node at the given index. (You will need to update the links of your nodes in the list when you remove a node.)

## Solution

- Code: [lib/linked_list.rb](lib/linked_list.rb)
- Rspec: [spec/lib/linked_list_spec.rb](spec/lib/linked_list_spec.rb)
