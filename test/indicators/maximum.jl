using Test
include("../../src/indicators/maximum.jl")

let
    m = Maximum(MaximumParams("SPY", 5, fifteenSeconds))
    processNewCandle(m, 151.89)
    processNewCandle(m, 149.0)
    processNewCandle(m, 150.02)
    processNewCandle(m, 151.91)
    processNewCandle(m, 151.61)
    @test m.current == 151.91
    processNewCandle(m, 152.11)
    @test m.current == 152.11
end


# 2/26/2013 12:00:00 AM,149.72,150.2,148.73,150.02,186331600,
# 2/27/2013 12:00:00 AM,149.89,152.33,149.76,151.91,143932600,
# 2/28/2013 12:00:00 AM,151.9,152.87,151.41,151.61,123724200,151.91
# 3/1/2013 12:00:00 AM,151.09,152.34,150.41,151.61,170612700,152.11
