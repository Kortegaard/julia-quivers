include("vertex.jl")
include("qtypes.jl")

Arrow(start::Vertex, termination::Vertex) = Arrow{Any}(start, termination)
Arrow(start::Vertex, termination::Vertex, value) = Arrow{typeof(value)}(start, termination, value)


start(arr::Arrow)::Vertex = arr.s
termination(arr::Arrow)::Vertex = arr.t
value(arr::Arrow) = arr.value


