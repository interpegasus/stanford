class Node
    attr_reader :value
    attr_reader :adjacent_nodes
    attr_reader :path
    def initialize(value)
        @value = value
        @adjacent_nodes = []
    end

    def add_edge(node)
        @adjacent_nodes.push(node)
    end

    def to_s
        "#{@value} -> [#{@adjacent_nodes.map(&:value).sort.join(" ")}]"
    end
end

class Graph
    attr_reader :nodes    
    def initialize
        @nodes = {}
    end

    def add_node(node)        
        @nodes[node.value] = node
    end

    def add_edge(node1,node2)
        if @nodes[node1.value].adjacent_nodes.map(&:value).include? (node2.value)        
            puts "#{node1.value} and #{node2.value} already have an edge"
        elsif node1.value == node2.value
            puts "node1.value == node2.value"
        else
            @nodes[node1.value].add_edge(@nodes[node2.value])
            @nodes[node2.value].add_edge(@nodes[node1.value])
        end
    end

    def to_s
        @nodes.keys.sort.each_with_index do |key,index|
            puts "#{index + 1}. #{@nodes[key].to_s}" 
        end
    end
end


def generate_random_graph
    g = Graph.new
    [*1..10].shuffle.each do |node_value|
        g.add_node(Node.new(node_value))
    end
    40.times do 
        key1 = g.nodes.keys.sample
        key2 = g.nodes.keys.sample
        g.add_edge(g.nodes[key1],g.nodes[key2])
    end
    return g
end

def bfs(graph, start_node_value, search_value)
    if graph.nodes[start_node_value].nil? || graph.nodes[search_value].nil?
        return nil
    end
    visited = Set.new
    search_queue = Queue.new
    search_queue.enq(graph.nodes[start_node_value])    
    while !search_queue.empty? do                
        current_node = search_queue.deq        
        visited.add(current_node)
        if current_node.value == search_value
            return current_node
        end
        current_node.adjacent_nodes.each do |node|
            if !visited.include?(graph.nodes[node.value])                
                search_queue.enq(graph.nodes[node.value])
            end
        end        
    end
end