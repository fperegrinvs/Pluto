include("models/indicator.jl")

struct MaximumParams <: IndicatorParams
    name::String
    source::String
    period::Int64
    resolution::Resolution
    MaximumParams(source, period, resolution) = new("maximum", source, period, resolution)
end

mutable struct Maximum <: PriceIndicator
    window::RollingWindow{Float64}
    params::MaximumParams
    current::Float64
    samples::Int64
    periodsSinceMaximum::Int64
    Maximum(params::MaximumParams) = new(RollingWindow{Float64}(params.period), params, 0, 0, 0)
end

function calculateCurrentValue(i::Maximum, currentValue::Float64)
    if i.samples == 1 || currentValue >= i.current
        i.periodsSinceMaximum = 0
        return currentValue
    end

    if i.periodsSinceMaximum >= (i.params.period - 1)
        mcopy = copyList(i.window)
        maxval, index = findmax(mcopy)
        i.periodsSinceMaximum = index
        return maxval
    end

    i.periodsSinceMaximum += 1
    return i.current
end
