# Stanford: Algorithms: Design and Analysis, Part 1 A3

def file_to_adjacency_list(file_path = "/Users/arturo/Downloads/Stanford/A3/kargerMinCut.txt")    
    graph = {}
    File.readlines(file_path).each do |line|
        line_items = line.split.map{|x| x.to_i}
        graph[line_items[0]] = line_items.slice(1,line_items.length - 1)
    end
    graph
end

def karger_contract(graph)     
    while(graph.length > 2)
        # Get random adjacent vertices
        vertex_one = graph.keys.sample
        vertex_two = graph[vertex_one].sample		
        
        graph[vertex_one].concat(graph[vertex_two])
        # Repoint edges previously on vertex_two to vertex_one
        graph[vertex_two].each do |vertex| 
            graph[vertex].map!{ |i| i == vertex_two ? vertex_one : i } 
        end
        # Remove self loops
        graph[vertex_one] = (graph[vertex_one].reject { |e| e == vertex_one })
        graph.delete(vertex_two)
    end
    graph.shift[1].length
end


def karger_min_cut
    output = []
    [*0..50].each do
        graph = file_to_adjacency_list
        output.push(karger_contract(graph))
    end
    output.min
end

class Node
    attr_reader :value
    attr_reader :adjacent_nodes
    def initialize(value)
        @value = value
        @adjacent_nodes = []
    end

    def add_adjacent_node(node)
        @adjacent_nodes.push(node)
    end

    def pretty_print
        "#{@value} -> [#{@adjacent_nodes.map(&:value).join(' ')}]"
    end
end

class Graph
    attr_reader :graph_nodes    
    def initialize
        @graph_nodes = {}
    end

    def add_node(node)        
        @graph_nodes[node.value] = node
    end

    def add_edge(node1,node2)
        @graph_nodes[node1.value].add_adjacent_node(node2)
    end

    def pretty_print
        @graph_nodes.keys.each_with_index do |key,index|
            puts "#{index + 1}. #{@graph_nodes[key].adjacent_nodes.map{|node_object| node_object.pretty_print}}" 
        end
    end
end

def test_graph
    g = Graph.new    
    n1= Node.new(1)
    n2= Node.new(2)
    n1.add_adjacent_node(n2)
    n2.add_adjacent_node(n1)
    g.add_node(n1)
    g.add_node(n2)
    n1.pretty_print
    n2.pretty_print
    g.pretty_print
end