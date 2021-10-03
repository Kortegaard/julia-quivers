
include("quiver.jl")
include("path.jl")





#q = BasicQuiver( Integer[1,2,3,4,5] )
println(typeof([Vertex(1),Vertex(2),Vertex(3)]))
q = Quiver([Vertex(1),Vertex(2),Vertex(3),Vertex(4)])#, ["a",1,2], ["b",3,2], ["c",2,4])
p = Quiver([1,2,3,4])#, ["a",1,2], ["b",3,2], ["c",2,4])
add_arrow!(q,Vertex(1),Vertex(3))
add_arrow!(q,Vertex(4),Vertex(1))
#add_arrow!(q,Vertex(1),Vertex(2))
println(q)
a = BasicArrow(Vertex(1),Vertex(4))
#b = BasicArrow(4,2)
#c = BasicArrow(2,3)
#d = BasicArrow(3,5)
#add_arrow!(q, a)
#add_arrow!(q, b)
#add_arrow!(q, c)
#add_arrow!(q, d)
# 
#q1 = a*b
#q = c*d
#
#p = q1*q
#
#println(typeof(p))
#println("path length: ", length(p))
#println("path start: ", start(p))
#println("path end: ", termination(p))
#
#println(q.adjacency_list)
#println("Arrow type: ", type_vertex(q))
#println("Vertex typeL ", type_arrow(q))
#println(typeof(start(a)))

#println(type_arrow(q))






## DREAMS
#

#q = Quiver([1,2,3,4], ["a",1,2], ["b",3,2], ["c",2,4])
#q = Quiver([Vertex(1),Vertex(2),Vertex(3)], [])#, ["a",1,2], ["b",3,2], ["c",2,4])

#v = vertices(q) #[1,2,3,4]
#arrs = arrows(q)  # 
#arrs["a"] = Arrow("a", 1, 2)




