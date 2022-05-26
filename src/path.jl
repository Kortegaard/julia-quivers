include("qtypes.jl")

#length(p::Path) = size(p.path)[begin]
start(p::Path)::Vertex = p.starting_point

function termination(p::Path)::Vertex 
    length(p) > 0 || return p.starting_point 
    termination(p.path[end])
end

# TODO: Erro should be 0 later
#function *(a1::Arrow, a2::Arrow)::Path 
#    termination(a1) == start(a2) || error("Termination of first arrow must be equal to start of the second arrow")
#    p = Path(Arrow[a1,a2], start(a1))
#end
#
#function *(p1::Path, p2::Path)::Path 
#    termination(p1) == start(p2) || error("Termination of first path must be equal to start of the second path")
#    p = Path(Arrow[p1.path...,p2.path...], start(p1))
#end









