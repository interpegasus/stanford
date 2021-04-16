# Stanford: Algorithms: Design and Analysis, Part 1 A4

def file_to_adjacency_list(file_path = "/Users/arturo/Downloads/Stanford/A3/kargerMinCut.txt")    
    graph = {}
    File.readlines(file_path).each do |line|
        line_items = line.split.map{|x| x.to_i}
        graph[line_items[0]] = line_items.slice(1,line_items.length - 1)
    end
    graph
end

