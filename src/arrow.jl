include("vertex.jl")
include("qtypes.jl")

Arrow(start::Any, termination::Any) = Arrow{Any}(start, termination)
Arrow(start::Any, termination::Any, value) = Arrow{typeof(value)}(start, termination, value)

Base.convert(::Type{Path}, a::Arrow{Val}) where {Val} = Path(a)

start(arr::Arrow) = arr.s
termination(arr::Arrow) = arr.t
value(arr::Arrow) = arr.value


