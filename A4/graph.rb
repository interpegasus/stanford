class Node
    attr_reader :value
    attr_reader :adjacent_nodes
    attr_reader :path_from_start
    def initialize(value)
        @value = value
        @adjacent_nodes = []
        @path_from_start = []
    end

    def add_edge(node)
        @adjacent_nodes.push(node)
    end

    def add_to_path(value)
        @path_from_start.push(value)
    end

    def concat_to_path(value_array)
        @path_from_start.concat(value_array)
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

def bfs(graph, start_node_value=2, search_value=9)
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

def bfs_shortest_path(graph, start=2, search=9)
    if graph.nodes[start].nil? || graph.nodes[search].nil?
        return nil
    end
    visited = Set.new
    visited.add(start)
    search_queue = Queue.new
    search_queue.enq(start)
    while !search_queue.empty? do      
        current_node_key = search_queue.deq  
        current_node = graph.nodes[current_node_key]                 
        current_node.add_to_path(current_node.value)
        if current_node.value == search
            return current_node.path_from_start
        end
        adjacent_nodes_array = current_node.adjacent_nodes.map{|x| x.value}
        adjacent_nodes_array.each do |value|
            if !visited.include?(value)                   
                search_queue.enq(value)
                visited.add(value)
                graph.nodes[value].concat_to_path(current_node.path_from_start)                
            end
        end        
    end
end


def test_graph
    graph = generate_random_graph    
    graph.to_s
    bfs_shortest_path(graph,2,9)
end



def dfs(graph, start)
end
