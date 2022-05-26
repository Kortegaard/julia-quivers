include("vertex.jl")
include("qtypes.jl")

Base.convert(::Type{Path}, a::Arrow) = Path(a)

start(arr::Arrow) = arr.start
termination(arr::Arrow) = arr.termination
label(arr::Arrow) = arr.label


