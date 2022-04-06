using Test
using CSVFiles
 
using DataFrames

include("../../src/indicators/maximum.jl")

let
    df = DataFrame(load(dirname(pwd()) * "/test/indicators/testData/spy_max.csv"))
    m = Maximum(MaximumParams("SPY", 5, fifteenSeconds))
    for i in 1:size(df, 1)
        candle = Candle(df[i, "Open"], df[i, "Close"], df[i, "High"], df[i, "Low"], 0, DateTime(2022))
        processNewCandle(m, candle.close)
        expected = df[i, "MAX_5"]
        if expected !== missing
            @test expected == m.current
        end
    end 
end
