import Dates
include("../indicators/models/indicator.jl")

@enum RunMode begin
    backTesting 
    dataCollection 
    paperTrading 
    liveTrading
end

@enum BacktestStorage begin
    fileSystem
end

@enum LogMode begin
    silent
    console
    full
end

@enum Broker begin
    ftx
end

Base.@kwdef struct DataProviderConfig
    marketDataFolder::String = dirname(pwd()) * "/marketData/ftx"
    bufferSize::Dates.Period = Dates.Day(1)
    baseCoin::String = "USD"
    onlyActiveMarkets::Bool = true
    marketSelector::Function = x -> true
    candleResolution::Resolution = fifteenSeconds
end

struct Balance
    coin::String
    free::Float64
    locked::Float64
end

Base.@kwdef struct SimulationConfig
    marketOrderSlippage::Float64 = 0.003
    transactionFeeMaker::Float64 = 0.0002
    transactionFeeTaker::Float64 = 0.0006
    initialBalance:: Array{Balance} = [Balance("USD", 1000.0, 0.0)]
 end

 Base.@kwdef struct TrainingConfig
    collectedDataName::String = "AllTrades"
    trainingDataFolder::String = dirname(pwd()) * "/training"
    tradeSizePercent::Float64 = 0.01
    granularity::Period = Dates.Minute(5)
    updateGap::Period = Dates.Minute(5)
    tradeExpiration::Period = Dates.Hour(4)
    saveInterval::Period = Dates.Day(1)
 end

 Base.@kwdef struct AnalysisConfig
    triggerIndicators::Array{String} = Array{String}()
    valuesPerGene:Int64 = 100
    populationSize::Int64 = 100
    mutationRate::Float64 = 0.30
    generations::Int64 = 30
    bestFitRate::Float64 = 0.4
    eldersRate::Float64 = 0.1
end

Base.@kwdef struct Config
    runMode::RunMode = backTesting
    backtestStorage::BacktestStorage = fileSystem
    logMode::LogMode = console
    broker::Broker = ftx
    startDate::Dates.DateTime = Dates.DateTime(2021, 1, 1, 0, 0)
    endDate::Dates.DateTime = Dates.DateTime(2022, 4, 1)
    dataProvider::DataProviderConfig = DataProviderConfig()
    simulation::SimulationConfig = SimulationConfig()
    training::TrainingConfig = TrainingConfig()
    analysis::AnalysisConfig = AnalysisConfig()
end
