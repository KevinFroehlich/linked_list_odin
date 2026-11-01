class LinkedList
    attr_accessor :root

    def initialize
        @root = nil
    end

    def append(value, node = @root)
        if node == nil

            @root = Node.new
            
            @root.value = value
        elsif node.next_node == nil
             node.next_node = Node.new
             node.next_node.value = value
        else
            append(value, node.next_node)
        end
    end
    def prepend_node(value)
        if @root == nil
            @root = Node.new
            @root.value = value
        else
            old_node = @root
            @root = Node.new
            @root.next_node = old_node
            @root.value = value
        end
    end
    def size(node = @root, count = 0)
        return count if node == nil
        size(node.next_node, count + 1)
    end

    def head
        return nil if @root == nil 
        return @root.value
    end

    def tail(node = @root)
        return nil if node == nil
        return node.value if node.next_node == nil
        tail(node.next_node) 
    end

    def at(index, node = @root, count = 0)
        if node == nil
            return nil
        elsif index == count
            return node.value
        end

        at(index, node.next_node, count + 1)

    end
    def pop(node = @root)
        return nil if node == nil
        new_node = node.next_node
        value = node.value
        @root = new_node
        return value
    end

    def contains?(value, node = @root)
        return false if node == nil
        return true if node.value == value
        contains?(value, node.next_node)
    end

    def index(value, node = @root, count = 0)
        return nil if node == nil
        return count if node.value == value
        index(value, node.next_node, count + 1)
    end

    def to_s(node = @root, string = "")
        return "" if @root == nil
        return string + " nil " if node == nil
        string += "( #{node.value} ) -> "
        to_s(node.next_node, string)
    end

    def insert_at(index, *values, node: @root, count: 0, connection_node: nil)
        raise IndexError, "index out of range" if index < 0 || index > self.size
        if values.empty? && connection_node != nil
            node.next_node = connection_node
            return
        elsif values.empty?
            return
        end

        if index == count
            connection_node = node.next_node if node.next_node != nil
            node.next_node = Node.new
            node.next_node.value = values.first
            values.shift
            
            insert_at(index, *values, node:node.next_node, count: count, connection_node:connection_node)
        else
            insert_at(index, *values, node: node.next_node, count: count + 1, connection_node: connection_node )        
        end
    end

    def remove_at(index, node = @root, count = 0)
        raise IndexError, "index out of range" if index < 0 || index > self.size
            return nil if @root == nil
            if index == 0
                self.pop
                return
            end
           
            if index - 1 == count
                node.next_node = node.next_node.next_node
            else
                remove_at(index, node.next_node, count +1)
            end
        end
end

class Node
    attr_accessor :value, :next_node

    def  initialize
        @value = nil 
        @next_node = nil
    end
end