
mutable struct Vertex{Val}
    value::Val 
end

struct Arrow{Val}
    s::Vertex
    t::Vertex
    value::Union{Val, Nothing}
    Arrow{Val}(start::Vertex, termination::Vertex) where {Val} = new{Val}(start, termination,nothing)
    Arrow{Val}(start::Vertex, termination::Vertex, val::Val) where {Val} = new{Val}(start, termination,val)
end

mutable struct Path{A <: Arrow}
    path::Vector{A}
    starting_point::Vertex
end

mutable struct Quiver
    vertices::Vector{Vertex}
    arrows::Vector{Arrow}
    #start_list::Dict{V, Vector{E}} #E[] has to be edges starting in V
    #termination_list::Dict{V, Vector{E}} #E[] has to be edges starting in V
end


BasicVertex = Vertex{Int}
BasicArrow = Arrow{Int}
BasicQuiver = Quiver

