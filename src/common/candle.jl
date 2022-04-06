using Dates

struct Candle
    open::Float64
    close::Float64
    high::Float64
    low::Float64
    volume::Float64
    startTime::DateTime 
end