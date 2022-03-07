LabelType = Union{Nothing, String, Int}

abstract type AbstractArrow end
 
mutable struct Vertex 
    label::LabelType
    start_arrows::Vector{<:AbstractArrow}
    termination_arrows::Vector{<:AbstractArrow}
    data::Any
    Vertex(label::LabelType) = new(label, Arrow[], Arrow[], Dict{String,Any}())
end

mutable struct Arrow <: AbstractArrow
    start::Vertex
    termination::Vertex
    label::LabelType
    data::Any
    Arrow(start::Vertex, termination::Vertex) = new(start, termination, nothing, Dict{String, Any}())
    Arrow(start::Vertex, termination::Vertex, label::LabelType) = new(start, termination, label, Dict{String, Any}())
end


mutable struct Path
    path::Vector{Arrow}
    start::Vertex
    termination::Vertex

    Path(path::Vector{Arrow}, start::Vertex, termination::Vertex) = new(path, start,termination)
    Path(path::Vector{Arrow}) = new(path, start(path[begin]), termination(path[end]))
    Path(p...) = new(collect(p), start(p[begin]), termination(p[end]))
end

mutable struct Quiver
    vertices::Vector{Vertex}

end
