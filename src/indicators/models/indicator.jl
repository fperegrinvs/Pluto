include("rollingWindow.jl")
include("../../common/candle.jl")

@enum Resolution fifteenSeconds=15 oneMinute=60 fiveMinutes=300

abstract type IndicatorParams end
abstract type Indicator{T <: Any} end
abstract type PriceIndicator <: Indicator{Float64} end

function isReady(i::Indicator{T}) where {T <: Any}
    i.window.samples >= i.params.period 
end

function toString(i::IndicatorParams)
    string(i.name * i.source * i.period * i.resolution)
end

function key(i::Indicator{T}) where {T <: Any}
    toString(i.params)
end

function calculateCurrentValue(i::PriceIndicator, value::Candle)
    calculateCurrentValue(i, value.close)
end

function calculateCurrentValue(i::Indicator{T}, candle::T) where {T <: Any}
    throw("unimplemented")
end

function processNewCandle(i::Indicator{T}, candle::T) where {T <: Any}
    add(i.window, candle)
    i.samples += 1
    i.current = calculateCurrentValue(i, candle)
end


function processNewCandle(i::Indicator{T}, candle::T) where {T <: Any}
    add(i.window, candle)
    i.samples += 1
    i.current = calculateCurrentValue(i, candle)
end
