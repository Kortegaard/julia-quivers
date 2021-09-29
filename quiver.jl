include("qtypes.jl")
include("vertex.jl")
include("arrow.jl")

#*(a1::Arrow, a2::Arrow)::Path

## QUIVER

Quiver{E,V}(vertices::Vector{V}) where {E, V} = Quiver{E,V}(E,V,vertices, Vector{E}()) # Dict{V, Vector{E}}())
#Quiver{E,V}(vertices::Vector{V}) where {E, V} = Quiver{E,V}(E,V,vertices, Vector{E}()) # Dict{V, Vector{E}}())


type_vertex(q::Quiver) = q.type_vertex
type_arrow(q::Quiver) = q.type_arrow

function add_arrow!(q::Quiver{E,V}, arrow::E) where {E,V} 
    arrow.s in q.vertices || error("The starting vertex must be contained in the quivers vertices.")
    arrow.t in q.vertices || error("The termination vertex must be contained in the quivers vertices.")
    #push!(get!(q.adjacency_list, arrow.s, V[]), arrow)
    push!(q.arrows, arrow)
end

function add_arrow!(q::Quiver{E,V}, start::V, termination::V) where {E,V} 
    #e = create_arrow(start,termination) #E(start, termination)
    add_arrow!(q,e)
end

function add_vertex!(q::Quiver{E,V}, vertex::V) where {E,V} 
    vertex in q.vertices && error("Vertex is already in quiver")
    push!(q.vertices, vertex)
end

function add_vertex!(q::Quiver, vertex::Any)
    v = Vertex(vertex)
    v in q.vertices && error("Vertex is already in quiver")
    push!(q.vertices, v)
end

num_vertices(q::Quiver{E,V}) where {E,V} = length(q.vertices)
num_arrows(q::Quiver{E,V}) where {E,V} = sum([length(d[2]) for d in q.adjacency_list])

type_arrow(q::Quiver{E,V}) where {E,V} = typeof(E)

