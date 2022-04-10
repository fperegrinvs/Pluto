using Test
using CSVFiles
using CSV
 
using DataFrames

include("../../src/indicators/maximum.jl")

let
    data = CSV.Rows(dirname(pwd()) * "/test/indicators/testData/spy_max.csv")
    function check(df)
        for j in 1:1000
            m = Maximum(MaximumParams("SPY", 5, fifteenSeconds))
            for row in data
                candle = Candle(parse(Float64, row.Open), parse(Float64, row.Close), parse(Float64, row.High), parse(Float64, row.Low), 0, DateTime(2022))
                processNewCandle(m, candle.close)
                expected = row.MAX_5
                if expected !== missing
                    #@test expected == m.current
                end
            end 
        end
    end

    check(data)

    @time check(data)
end
