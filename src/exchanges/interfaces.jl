abstract type externalCandleSource end

#fun getMarkets(): Response<List<MarketDetails>>
#fun getHistoricalPrices(marketName: String, resolution: Int, startTime: LocalDateTime? = null, endTime: LocalDateTime? = null)
#        : Response<List<Candle>>
