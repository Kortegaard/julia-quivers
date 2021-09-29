
function start(arr::AbstractArrow)::Vertex
    error("Must implement start of arrow")
end

function termination(arr::AbstractArrow)::Vertex
    error("Must implement termination of arrow")
end

Arrow{V,Val}(start::V, termination::V) where {V,Val} = Arrow{V,Val}(nothing, start, termination)
Arrow{V,Val}(val::Val, start::V, termination::V) where {V,Val} = Arrow{V,Val}(val, start, termination)
#Arrow{any,any}(val::Val, start::V, termination::V) where {V,Val} = 56
#Arrow{V,VV}(start::any, termination::any) where {V, VV}= Arrow{V,Val}(nothing, vertex{Int}(3),vertex{Int}(3))
#Arrow(start::any, termination::any) = Arrow{typeof(start),typeof(termination)}(nothing, Vertex{typeof(start)}, Vertex{typeof(termination)}(termination))

start(arr::Arrow)::Vertex = arr.s
termination(arr::Arrow)::Vertex = arr.t
value(arr::Arrow) = arr.value


