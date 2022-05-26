include("main.jl")

using LinearAlgebra

function normalize_quiver!(q::Quiver)
    midpoint = sum(map(x->x.data["position"],vertices(q)))/length(vertices(q))
    for v in vertices(q)
        v.data["position"] = v.data["position"] - midpoint
    end
    length_of_longest = max([norm(x.data["position"]) for x in vertices(q)]...)
    for v in vertices(q)
        v.data["position"] = v.data["position"]/length_of_longest
    end
end

function setup_quiver_data!(q::Quiver)
    for v in vertices(q)
        v.data = Dict{String, Any}(
            "position" => Vector{Float64}([0,0]),
        )
    end
end

function set_random_position!(v::Vertex)
    v.data["position"] = Vector{Float64}(rand(2))
end

function set_random_positions!(q::Quiver)
    for v in vertices(q)
        set_random_position!(v)
    end
end

function F0(u::Vector{Float64}, v::Vector{Float64}, c0::Float64)
    return (normalize(v-u)/(norm(v - u)^2/c0))
end

function F0(u::Vector{Float64}, v::Vector{Float64})
    return F0(u,v,1);
end

function F1(u::Vector{Float64}, v::Vector{Float64}, c1::Float64)
    #natural length
    l = 0.001
    return normalize(v-u)*(-c1 * (norm(v-u)-l)) 
end

function F1(u::Vector{Float64}, v::Vector{Float64})
    return F1(u,v,1);
end

function F(q::Quiver, v::Vertex, c0::Float64, c1::Float64)
    Force = [0.0,0.0]

    for u in vertices(q)
        if u == v
            continue
        end
        Force = Force + F0(u.data["position"], v.data["position"], c0)
    end
    for arr in v.termination_arrows
        Force = Force + F1(arr.start.data["position"], v.data["position"], c1)
    end
    for arr in v.start_arrows
        Force = Force + F1(arr.termination.data["position"], v.data["position"], c1)
    end
    return Force
end

function F(q::Quiver, v::Vertex)
    return F(q,v,1,1);
end

function spring_step(q::Quiver,delta::Float64, c0::Float64 ,c1::Float64)
    c = Dict{Vertex, Vector{Float64}}()
    for v in vertices(q)
        if !get(v.data, "springFrozen", false)
            c[v] = F(q, v, c0, c1)
        end
    end
    for v in vertices(q)
        if haskey(c, v)
            v.data["position"] = v.data["position"] + delta * c[v];
        end
    end
end
