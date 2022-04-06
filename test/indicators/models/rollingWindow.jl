using Test
include("../../../src/indicators/models/rollingWindow.jl")

let 
    window = RollingWindow{Int64}(1)
    @test window.size == 1
    @test window.samples == 0
end

let
    window = RollingWindow{Int64}(2)
    @test window.size == 2
    @test window.samples == 0
    @test size(window.list)[1] == 0

    add(window, 1)
    @test window.size == 2
    @test window.samples == 1
    @test size(window.list)[1] == 1

    add(window, 2)
    @test window.size == 2
    @test size(window.list)[1] == 2
    @test window.samples == 2
end

let 
    window = RollingWindow{Int64}(3)
    @test window.size == 3

    add(window, 0)
    @test count(window) == 1

    add(window, 1)
    @test count(window) == 2
    @test window[2] == 0
    @test window[1] == 1

    add(window, 2)
    @test count(window) == 3
    @test window[3] == 0
    @test window[2] == 1
    @test window[1] == 2

    add(window, 3)
    @test count(window) == 3
    @test window[3] == 1
    @test window[2] == 2
    @test window[1] == 3
end
