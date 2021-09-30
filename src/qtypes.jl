
mutable struct Vertex{Val}
    value::Val 
end

#abstract type Arrow end

struct Arrow{Val} 
    s::Vertex
    t::Vertex
    value::Union{Val, Nothing}
    Arrow{Val}(start::Vertex, termination::Vertex) where {Val} = new{Val}(start, termination,nothing)
    Arrow{Val}(start::Vertex, termination::Vertex, val::Val) where {Val} = new{Val}(start, termination,val)
end

mutable struct Path
    path::Vector{Arrow}
    starting_point::Vertex

    Path(path::Vector{Arrow}, starting_point::Vertex) = new(path, starting_point)
    Path(path::Vector{Arrow}) = new(path, start(path[begin]))
    Path(path::Vector{Arrow{Val}}) where Val = new(path, start(path[begin]))
    Path(p...) where Val = new(collect(p), start(p[begin]))
end

mutable struct Quiver
    vertices::Vector{Vertex}
    arrows::Vector{Arrow}
end

BasicVertex = Vertex{Int}
BasicArrow = Arrow{Int}
BasicQuiver = Quiver

