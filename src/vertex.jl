include("qtypes.jl")

Base.convert(::Type{Vertex{T}}, a::T) where {T} = Vertex{T}(a)
Base.convert(::Type{Vertex{T}}, a::Vertex{S}) where {T,S} = Vertex{T}(a.value)

Base.convert(::Type{Path}, p::Vertex{T}) where {T} = Path(Vector{Arrow}(), p)
Base.hash(v::Vertex{T}) where {T} = Base.hash(v.value)
Base.:(==)(a::Vertex{T}, b::Vertex{T}) where {T} = (a.value == b.value)


