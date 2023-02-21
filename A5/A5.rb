@file_path = "/Users/arturo/interpegasus/stanford/A5/dijkstraData.txt"
# Define a function to read the graph from file
def read_graph(filename)
  graph = {}

  File.open(filename, 'r') do |file|
    file.each_line do |line|
      # Split the line into vertex and edges
      data = line.split(/\s+/)
      vertex = data[0].to_i
      edges = data[1..-1].map { |edge| edge.split(',').map(&:to_i) }

      # Add the vertex to the graph
      graph[vertex] = {}

      # Add the edges to the vertex
      edges.each do |edge|
        graph[vertex][edge[0]] = edge[1]
        graph[edge[0]] ||= {}
        graph[edge[0]][vertex] = edge[1]
      end
    end
  end

  graph
end

# Define a function to compute the shortest path from a source vertex to all other vertices
def dijkstra_shortest_path(graph, source)
  # Initialize the distances and visited vertices arrays
  distances = {}
  visited = []

  graph.keys.each do |vertex|
    distances[vertex] = 1_000_000
  end

  distances[source] = 0

  # Loop through all vertices in the graph
  while visited.length < graph.length
    # Find the unvisited vertex with the minimum distance
    min_distance = 1_000_000
    current_vertex = nil

    distances.each do |vertex, distance|
      if !visited.include?(vertex) && distance < min_distance
        min_distance = distance
        current_vertex = vertex
      end
    end

    # Mark the current vertex as visited
    visited << current_vertex

    # Update the distances to the neighbors of the current vertex
    graph[current_vertex].each do |neighbor, distance|
      if !visited.include?(neighbor)
        new_distance = distances[current_vertex] + distance
        if new_distance < distances[neighbor]
          distances[neighbor] = new_distance
        end
      end
    end
  end

  distances
end

# Read the graph from file
graph = read_graph(@file_path)

# Compute the shortest path from vertex 1 to the specified vertices
destinations = [7, 37, 59, 82, 99, 115, 133, 165, 188, 197]

distances = dijkstra_shortest_path(graph, 1)

destinations.each do |destination|
  puts "Shortest path from 1 to #{destination}: #{distances[destination]}"
end