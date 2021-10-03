
mutable struct Vertex{Val}
    value::Val 
end

#abstract type Arrow end

struct Arrow{Val} 
    s::Any
    t::Any
    value::Union{Val, Nothing}
    Arrow{Val}(start::Any, termination::Any) where {Val} = new{Val}(start, termination,nothing)
    Arrow{Val}(start::Any, termination::Any, val::Val) where {Val} = new{Val}(start, termination,val)
end

mutable struct Path
    path::Vector{Arrow}
    starting_point

    Path(path::Vector{Arrow}, starting_point::Any) = new(path, starting_point)
    Path(path::Vector{Arrow}) = new(path, start(path[begin]))
    Path(path::Vector{Arrow{Val}}) where Val = new(path, start(path[begin]))
    Path(p...) where Val = new(collect(p), start(p[begin]))
end

mutable struct Quiver{V}
    vertices::Vector{V}
    arrows::Vector{Arrow}
end

BasicVertex = Vertex{Int}
BasicArrow = Arrow{Int}
BasicQuiver = Quiver

