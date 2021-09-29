
abstract type AbstractQuiver end
abstract type AbstractArrow end
abstract type AbstractVertex end

#const Vertex = Any

mutable struct Vertex{Val} <: AbstractVertex
    value::Val 
end

struct Arrow{V <: Vertex, Val} <: AbstractArrow
    value::Union{Val, Nothing}
    s::V
    t::V
end

mutable struct Path{A <: AbstractArrow}
    path::Vector{A}
    starting_point::Vertex
end

mutable struct Quiver{E <: AbstractArrow,V <: Vertex} <: AbstractQuiver
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

### INTERFACE
function type_arrow(q::AbstractQuiver)::DataType
    error("Must implement type_arrow")
end

function type_vertex(q::AbstractQuiver)::DataType
    error("Must implement type_vertex")
end

function start(arr::AbstractArrow)::Vertex
    error("Must implement start of arrow")
end

function termination(arr::AbstractArrow)::Vertex
    error("Must implement termination of arrow")
end



