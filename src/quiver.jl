include("qtypes.jl")
include("vertex.jl")
include("arrow.jl")

#Nice print statements
Base.show(io::IO, arr::Arrow) = print(string(arr.start.label, " --> " ,arr.termination.label))
Base.show(io::IO, v::Vertex) = print(string(v.label))
Base.show(io::IO, q::Quiver) = print("Quiver(", vertices(q),")")


function find_vertex(q::Quiver, v::Vertex)::Union{Nothing, Vertex}
    for u in vertices(q)
        if u == v
            return u
        end
    end
    return nothing
end

function add_arrow!(q::Quiver, arrow::Arrow)
    v_start_index = get(findall(x->x==start(arrow), q.vertices),1,-1)
    if v_start_index == -1
        error("The starting vertex must be contained in the quivers vertices.")
    end

    v_end_index = get(findall(x->x==termination(arrow), q.vertices),1,-1)
    if v_end_index == -1
        error("The termination vertex must be contained in the quivers vertices.")
    end

    v_start = vertices(q)[v_start_index]
    v_end = vertices(q)[v_end_index]
    arrow.start = v_start
    arrow.termination = v_end

    push!(v_start.start_arrows, arrow)
    push!(v_end.termination_arrows, arrow)
end

function add_arrow!(q::Quiver, start::Vertex, termination::Vertex)
    arr = Arrow(start,termination)
    add_arrow!(q,arr)
end

function add_vertices!(q::Quiver, vertices::Vector{Vertex})
    for v in vertices
        add_vertex!(q, v);
    end
end

function add_vertex!(q::Quiver, vertex::Vertex)
    vertex in q.vertices && error("Vertex is already in quiver")
    push!(q.vertices, vertex)
end

function add_vertex!(q::Quiver, vertex::LabelType)
    v = Vertex(vertex)
    v in q.vertices && error("Vertex is already in quiver")
    push!(q.vertices, v)
end

function arrows(q::Quiver)::Vector{Arrow}
    l = Vector{Arrow}()
    for v in vertices(q)
        for a in v.start_arrows
            push!(l, a)
        end
    end
    return l;
end

function exists_arrow(q::Quiver, from::Vertex, to::Vertex)::Bool
    for a in arrows(q)
        if a.start == from && a.termination == to
            return true
        end
    end
    return false
end

function exists_arrow(q::Quiver, arr::Arrow)::Bool
    for a in arrows(q)
        if a.start == arr.start && a.termination == arr.termination
            return true
        end
    end
    return false
end

function find_arrow(q::Quiver, from::Vertex, to::Vertex)::Union{Nothing, Arrow}
    for a in arrows(q)
        if a.start == from && a.termination == to
            return a
        end
    end
    return nothing
end

function neighbours(q::Quiver, v::Vertex)
    verts = []
    for a in v.start_arrows
        if !(a.termination in verts)
            push!(verts, a.termination)
        end
    end
    for a in v.termination_arrows
        if !(a.start in verts)
            push!(verts, a.start)
        end
    end
    return verts
end


num_vertices(q::Quiver) = length(q.vertices)
vertices(q::Quiver) = q.vertices

#TODO
num_arrows(q::Quiver) = 0
is_path(q::Quiver, p::Path)::Bool = false
has_cycles(q::Quiver)::Bool = false
get_paths(q::Quiver)::Vector{Path} = []
