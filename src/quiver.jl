include("qtypes.jl")
include("vertex.jl")
include("arrow.jl")


## QUIVER

Quiver(vertices::Vector{Vertex{T}}) where {T} = Quiver(vertices, Vector{Arrow}()) # Dict{V, Vector{E}}())

type_vertex(q::Quiver) = q.type_vertex
type_arrow(q::Quiver) = q.type_arrow

function add_arrow!(q::Quiver, arrow::Arrow)
    arrow.s in q.vertices || error("The starting vertex must be contained in the quivers vertices.")
    arrow.t in q.vertices || error("The termination vertex must be contained in the quivers vertices.")
    #push!(get!(q.adjacency_list, arrow.s, V[]), arrow)
    push!(q.arrows, arrow)
end

function add_arrow!(q::Quiver, start::Vertex, termination::Vertex)
    #e = create_arrow(start,termination) #E(start, termination)
    add_arrow!(q,e)
end

function add_vertex!(q::Quiver, vertex::Vertex)
    vertex in q.vertices && error("Vertex is already in quiver")
    push!(q.vertices, vertex)
end

function add_vertex!(q::Quiver, vertex::Any)
    v = Vertex(vertex)
    v in q.vertices && error("Vertex is already in quiver")
    push!(q.vertices, v)
end

num_vertices(q::Quiver) = length(q.vertices)
num_arrows(q::Quiver) = sum([length(d[2]) for d in q.adjacency_list])
type_arrow(q::Quiver) = typeof(E)

