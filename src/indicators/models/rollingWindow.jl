mutable struct RollingWindow{T <: Any}
    size::Int64
    list::Array{T}
    tail::Int64
    previousIndex::Int64
    mostlyRecentlyRemoved::T
    samples::Int64
    RollingWindow{T}(size::Number) where {T <: Any} = new(size, Array{T}[], 1)    
end

function Base.getindex(r::RollingWindow{T}, i::Int64) where {T <: Any}
    s = size(r.list)[1]
    if i < 0 || i > s
        throw(ArgumentError)
    end

    x = mod((s + r.tail - i - 1), s) + 1
    r.list[x]
end

function copyList(r::RollingWindow{T}) where {T <: Any}
    a = Array{T}()
    for i in 1:size(r.list)[1]
        append!(a, r[i])
    end
end

function count(r::RollingWindow{T}) where {T <: Any}
    size(r.list)[1]
end

function add(r::RollingWindow{T}, i::T) where {T <: Any}
    r.samples += 1
    if size(r.list)[1] == r.size
        r.mostlyRecentlyRemoved = r.list[r.tail]
        r.list[r.tail] = i 
        r.previousIndex = r.tail
        r.tail = mod(r.tail + 1, r.size)
    else 
        append!(r.list, i)
    end   
end
