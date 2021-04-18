# Stanford: Algorithms: Design and Analysis, Part 1 A

def file_to_graph(file_path = "/Users/arturo/Downloads/Stanford/A4/SCC.txt")    
    graph = Graph.new
    File.readlines(file_path).each do |line|
        line_items = line.split.map{|x| x.to_i}
        if graph.nodes[line_items[0]].nil?
            graph.add_node(Node.new(line_items[0]))            
        end
        if graph.nodes[line_items[1]].nil?
            graph.add_node(Node.new(line_items[1]))            
        end
        graph.add_outgoing_edge_from_to(graph.nodes[line_items[0]],graph.nodes[line_items[1]])
    end
    graph
end

class Node
    attr_reader :value    
    attr_reader :outgoing_edges
    attr_reader :incoming_edges
    attr_reader :is_leader
    attr_reader :is_explored
    def initialize(value)
        @value = value
        @outgoing_edges = []
        @incoming_edges = []
        @is_leader = false
        @is_explored = false
    end

    def add_outgoing_edge(node)
        @outgoing_edges.push(node.value)
    end

    def add_incoming_edge(node)
        @incoming_edges.push(node.value)
    end    

    def set_is_explored
        @is_explored = true
    end

    def set_is_leader
        @is_leader = true
    end

    def reverse
        (@outgoing_edges,@incoming_edges) = [@incoming_edges,@outgoing_edges]
    end

    def to_s
        puts "Node #{@value} -> Outgoing Edges: [#{@outgoing_edges.sort.join(" ")}]"
        puts "Node #{@value} <- Incoming Edges: [#{@incoming_edges.sort.join(" ")}]"
    end
end

class Graph
    attr_reader :nodes    
    def initialize
        @nodes = {}
        @strong_components = {}
        counter = 0
    end

    def add_node(node)        
        @nodes[node.value] = node
    end

    def add_incoming_edge_from_to(node1,node2)
        if @nodes[node1.value].incoming_edges.include? (node2.value)        
            puts "#{node1.value} and #{node2.value} already have an incoming edge"
        elsif node1.value == node2.value
            puts "Adding Incoming Edge #{node1.value} == #{node2.value}"
        else
            @nodes[node1.value].add_incoming_edge(@nodes[node2.value])
            @nodes[node2.value].add_outgoing_edge(@nodes[node1.value])
        end
    end

    def add_outgoing_edge_from_to(node1,node2)
        if @nodes[node1.value].outgoing_edges.include? (node2.value)        
            puts "#{node1.value} and #{node2.value} already have an incoming edge"
        elsif node1.value == node2.value
            puts "Adding Outgoing Edge #{node1.value} == #{node2.value}"
        else
            @nodes[node1.value].add_outgoing_edge(@nodes[node2.value])
            @nodes[node2.value].add_incoming_edge(@nodes[node1.value])
        end
    end   

    def to_s
        @nodes.keys.sort.each_with_index do |key|
            puts "#{@nodes[key].to_s}" 
        end
    end
end


def dfs_iterative(graph, start, search=4)
    stack = Stack.new    
    discovered = []
    stack.push(start)
    while !stack.is_empty? do
        node = graph.nodes[stack.pop]
        if !discovered.include? node.value
            discovered.push(node.value)
            if node.value == search
                # Return Found
            end
            node.adjacent_nodes.each do |adjacent_node|
                stack.push(adjacent_node.value)
            end
        end
    end
end