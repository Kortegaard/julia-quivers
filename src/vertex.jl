include("qtypes.jl")

Base.convert(::Type{Vertex}, a::LabelType) = Vertex(a)
Base.convert(::Type{Path}, p::Vertex) = Path(Vector{Arrow}(), p, p)

#Assuming vertex uniquely giving by label
Base.hash(v::Vertex) = Base.hash(v.label)
Base.:(==)(a::Vertex, b::Vertex) = (a.label == b.label)


