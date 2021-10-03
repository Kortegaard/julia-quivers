include("qtypes.jl")
include("vertex.jl")
include("arrow.jl")


## QUIVER

#Quiver(vertices::Vector{Vertex{T}}) where {T} = Quiver{Vertex}(vertices, Vector{Arrow}()) # Dict{V, Vector{E}}())
Quiver(vertices::Vector{T}) where {T} = Quiver{T}(vertices, Vector{Arrow}()) # Dict{V, Vector{E}}())

type_vertex(q::Quiver) = q.type_vertex
type_arrow(q::Quiver) = q.type_arrow

function add_arrow!(q::Quiver, arrow::Arrow)
    arrow.s in q.vertices || error("The starting vertex must be contained in the quivers vertices.")
    arrow.t in q.vertices || error("The termination vertex must be contained in the quivers vertices.")
    #push!(get!(q.adjacency_list, arrow.s, V[]), arrow)
    push!(q.arrows, arrow)
end

function add_arrow!(q::Quiver{T}, start::T, termination::T) where {T}
    e = Arrow(start,termination) #E(start, termination)
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

#TODO
is_path(q::Quiver, p::Path)::Bool = false
has_cycles(q::Quiver)::Bool = false
get_paths(q::Quiver)::Vector{Path} = []

function is_connected(q::Quiver{T})::Bool where {T}
    al = adjacency_list(q)
    Queue = Vector{T}()
    explored = Dict{T, Bool}(w => false for w in q.vertices)
    v = q.vertices[begin]
    explored[v] = true
    push!(Queue, v)
    while size(Queue)[begin] > 0
        v = popfirst!(Queue)
        println("explore: ", v)
        for w in get(al, v, [])
            get(explored, w, false) && continue
            explored[w] = true
            push!(Queue, w)
        end
    end
    println(explored)
    return all(values(explored))
end

"""
Givin list of arrows, starting and terminating in given vertices.

PARAMETERS:
q::Quiver - 

RETURN
    Tuple{Dict} R = (R1, R2)
    R1 : Arrows starting in vertex, indexes by vertices.
    R2 : Arrows ending in vertex, indexes by vertices.
"""
function arrows_indexed_by_vertices(q::Quiver{T}) where {T}
    start_in_vertex = Dict{T, Vector{Arrow}}()
    end_in_vertex = Dict{T, Vector{Arrow}}()

    for arr in q.arrows
        push!(get!(start_in_vertex, start(arr), Vector{Arrow}()), arr)
        push!(get!(end_in_vertex, termination(arr), Vector{Arrow}()), arr)
    end
    return start_in_vertex, end_in_vertex
end

function adjacency_list(q::Quiver{T})::Dict{T, Vector{T}} where {T}
    arr_start_in_vertex, arr_end_in_vertex  = arrows_indexed_by_vertices(q)
    al = Dict{T, Vector{T}}()
    for v in q.vertices
        s1 = map(a::Arrow -> termination(a), get(arr_start_in_vertex,v,[]))
        s2 = map(a::Arrow -> start(a), get(arr_end_in_vertex,v,[]))
        al[v] = union(s1,s2)
    end
    return al
end
