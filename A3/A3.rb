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