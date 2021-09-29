
mutable struct Vertex{Val}
    value::Val 
end

struct Arrow{V <: Vertex, Val}
    s::V
    t::V
    value::Union{Val, Nothing}
    Arrow{V,Val}(start::V, termination::V) where {V,Val} = new{V,Val}(start, termination,nothing)
    Arrow{V,Val}(start::V, termination::V, val::Val) where {V,Val} = new{V,Val}(start, termination,val)
end

mutable struct Path{A <: Arrow}
    path::Vector{A}
    starting_point::Vertex
end

mutable struct Quiver{E <: Arrow, V <: Vertex}
    type_arrow::DataType
    type_vertex::DataType
    vertices::Vector{V}
    arrows::Vector{E}
    #start_list::Dict{V, Vector{E}} #E[] has to be edges starting in V
    #termination_list::Dict{V, Vector{E}} #E[] has to be edges starting in V
end


BasicVertex = Vertex{Int}
BasicArrow = Arrow{BasicVertex, Int}
BasicQuiver = Quiver{BasicArrow, BasicVertex}

