
abstract type Asset end

mutable struct LogReturn <: Asset  # Asset log return
    values::Vector{Float64}
    timestamp::Vector{<:TimeType}
    freq::String
    scale::Float64
    id::String
    exchange::String
end

mutable struct SimpleReturn <: Asset   # Asset simple return
    values::Vector{Float64}
    timestamp::Vector{<:TimeType}
    freq::String
    scale::Float64
    id::String
    exchange::String
end

mutable struct AssetPrice <: Asset
    values::Vector{Float64}
    timestamp::Vector{<:TimeType}
    freq::String
    scale::Float64
    id::String
    exchange::String
end

mutable struct CommodityPrice <: Asset
    values::Vector{Float64}
    date::Vector{<:TimeType}
    freq::String
    id::String
    currency::String
    unit::String
    exchange::String
end

"""
    Base.values(x::AssetPrice)

Returns a vector of prices of the asset.
"""
Base.values(x::AssetPrice) = x.values

"""
    timestamp(x::AssetPrice)

Returns a vector of the timestamps of the asset.
"""
timestamp(x::AssetPrice) = x.timestamp

"""
    scale(x::AssetPrice)

Returns the scaling number for the asset. Used to for annualization.
"""
scale(x::AssetPrice) = x.scale

"""
    id(x::AssetPrice)

Returns the id (ticker) of the asset.
"""
id(x::AssetPrice) = x.id

####

"""
    Base.values(x::LogReturn)

Returns a vector of returns of the asset.
"""
Base.values(x::LogReturn) = x.values

"""
    timestamp(x::LogReturn)

Returns a vector of the timestamps of the asset.
"""
timestamp(x::LogReturn) = x.timestamp

"""
    scale(x::LogReturn)

Returns the scaling number for the asset. Used to for annualization.
"""
scale(x::LogReturn) = x.scale

"""
    id(x::LogReturn)

Returns the id (ticker) of the asset.
"""
id(x::LogReturn) = x.id

####

"""
    Base.values(x::SimpleReturn)

Returns a vector of returns of the asset.
"""
Base.values(x::SimpleReturn) = x.values

"""
    timestamp(x::SimpleReturn)

Returns a vector of the timestamps of the asset.
"""
timestamp(x::SimpleReturn) = x.timestamp

"""
    scale(x::SimpleReturn)

Returns the scaling number for the asset. Used to for annualization.
"""
scale(x::SimpleReturn) = x.scale

"""
    id(x::SimpleReturn)

Returns the id (ticker) of the asset.
"""
id(x::SimpleReturn) = x.id

####

function Base.show(io::IO, obj::LogReturn) 
    print(io, "Symbol: $(obj.id) ($(obj.exchange))\nFrequency: $(obj.freq)\tPeriods: $(size(obj.values,1))\nFrom: $(minimum(obj.timestamp))\tTo: $(maximum(obj.timestamp))\n")
    Base.show(io,[obj.timestamp obj.values]::Matrix)
end

function Base.show(io::IO, obj::SimpleReturn) 
    print(io, "Symbol: $(obj.id) ($(obj.exchange))\nFrequency: $(obj.freq)\tPeriods: $(size(obj.values,1))\nFrom: $(minimum(obj.timestamp))\tTo: $(maximum(obj.timestamp))\n")
    Base.show(io,[obj.timestamp obj.values]::Matrix)
end

function Base.show(io::IO, obj::AssetPrice) 
    print(io, "Symbol: $(obj.id) ($(obj.exchange))\nFrequency: $(obj.freq)\tPeriods: $(size(obj.values,1))\nFrom: $(minimum(obj.timestamp))\tTo: $(maximum(obj.timestamp))\n")
    Base.show(io,[obj.timestamp obj.values]::Matrix)
end

function Base.summary(obj::LogReturn)
    print("Symbol: $(obj.id) ($(obj.exchange))
    From: $(minimum(obj.timestamp))\tTo: $(maximum(obj.timestamp))\tFrequency: $(obj.freq)\tPeriods: $(size(obj.values,1))
    Arith: $(round(annualize(mean_arith(obj),obj.scale)*100,digits=2))%\tGeo: $(round(annualize(mean_geo(obj),obj.scale)*100,digits=2))%\tStd: $(round(stdvs(obj)*sqrt(obj.scale)*100,digits=2))%
    Skewness: $(round(skew(obj.values,"sample"),digits=2))\tKurtosis: $(round(kurt(obj.values,"sample"),digits=2))")
end

function Base.summary(obj::SimpleReturn)
    print("Symbol: $(obj.id) ($(obj.exchange))
    From: $(minimum(obj.timestamp))\tTo: $(maximum(obj.timestamp))\tFrequency: $(obj.freq)\tPeriods: $(size(obj.values,1))
    Arith: $(round(annualize(mean_arith(obj),obj.scale)*100,digits=2))%\tGeo: $(round(annualize(mean_geo(obj),obj.scale)*100,digits=2))%\tStd: $(round(stdvs(obj)*sqrt(obj.scale)*100,digits=2))%
    Skewness: $(round(skew(obj.values,"sample"),digits=2))\tKurtosis: $(round(kurt(obj.values,"sample"),digits=2))")
end

_TIME_PERIODS = Dict("1m" => Dict("text"=>"1 Minute","scale"=> x-> x*60 *252),
                    "2m" => Dict("text"=>"2 Minutes","scale"=>x-> x*60 *252/2),
                    "5m" => Dict("text"=>"5 Minutes","scale"=>x-> x*60 *252/5),
                    "15m" => Dict("text"=>"15 Minutes","scale"=>x-> x*60 *252/15),
                    "30m" => Dict("text"=>"30 Minutes","scale"=>x-> x*60 *252/30),
                    "60m" => Dict("text"=>"60 Minutes","scale"=>x-> x*60 *252/60),
                    "90m" => Dict("text"=>"90 Minutes","scale"=>x-> x*60 *252/90),
                    "1h" => Dict("text"=>"1 Hour","scale"=>x-> x*252),
                    "1d" => Dict("text"=>"1 Days","scale"=>x->252),
                    "5d" => Dict("text"=>"5 Days","scale"=>x->252/5),
                    "1wk" => Dict("text"=>"1 Week","scale"=>x->52),
                    "1mo" => Dict("text"=>"1 Month","scale"=>x->12),
                    "3mo" => Dict("text"=>"3 Months","scale"=>x->4))

_Exchange_Daily_Hours = Dict(
    "SNP" => Dict(:h =>6.5,:name =>"SNP"),
    "NYSE" => Dict(:h =>6.5,:name =>"New York Stock Exchange"),
    "NasdaqGS" => Dict(:h =>6.5,:name =>"Nasdaq"),
    "Toronto" => Dict(:h =>6.5,:name =>"Toronto Stock Exchange"),
    "Shanghai" => Dict(:h =>4,:name =>"Shanghai Stock Exchange"),
    "Tokyo" => Dict(:h =>5,:name =>"Tokyo Stock Exchange"),
    "Shenzhen" => Dict(:h =>4 - (3/60),:name =>"Shenzhen Stock Exchange"),
    "HKSE" => Dict(:h =>5.5,:name =>"Stock Exhcnage of Hong Kong"),
    "NSE"=>   Dict(:h =>6.25,:name =>"National Stock Exchange of India"),
    "Saudi"=> Dict(:h =>5,:name =>"Saudi Stock Exchange"),
    "BSE"=> Dict(:h =>7.25,:name =>"BSE Limited"),
    "KSE"=> Dict(:h =>6.5,:name =>"Korea Exchange"),
    "Taiwan"=> Dict(:h =>4.25,:name =>"Taiwan Stock Exchange"),
    "LSE"=> Dict(:h =>8.5 - (2/60),:name =>"London Stock Exchange"),
    "Frankfurt"=> Dict(:h =>8.5,:name =>"Frankfurt Stock Exchange"),
    "Swiss"=> Dict(:h =>8 + 1/3,:name =>"SIX Swiss Exchange"),
    "Amsterdam"=> Dict(:h =>8.5,:name =>"Euronext Amsterdam"),
    "Paris"=> Dict(:h =>8.5,:name =>"Euronext Amsterdam"),
    "São Paulo"=>   Dict(:h =>8 - (5/60),:name =>"B3 S.A."),
    "ASX"=> Dict(:h =>6,:name =>"Australian Securities Exchange"),
    "Johannesburg"=> Dict(:h =>8,:name =>"Johannesburg Stock Exchange"),
    "NYSEArca" => Dict(:h =>6.5 ,:name =>"NYSE Arca"))

    _Exchange_Daily_Hours["Lisbon"] = Dict(:h => 8.5, :name => "Euronext Lisbon") # Add Euronext Lisbon

get_scaling_factor(freq,exchange) = _TIME_PERIODS[freq]["scale"](_Exchange_Daily_Hours[exchange][:h])



"""
    AssetPrice(ticker::String,from::TimeType,to::TimeType,interval::String="1d",exchange_local_time=true)

Generates a AssetPrice struct.

# Arguments
   * ticker the Yahoo Finance ticker
   * from a start time/date (either a `::Date` or `::DateTime`) 
   * to a end time/date (either a `::Date` or `::DateTime`)
   * freq the frequency of data. One of   "3mo","1mo","1wk","5d","1d",1h","90m","60m","30m","15m","5m","2m","1m"
   * exchange_local_time use the local time of the exchange as the timestamp (defaults to true)

# Returns
    AssetPrice
"""
function AssetPrice(ticker::String,from::TimeType,to::TimeType; interval::String="1d", exchange_local_time=true)
    p = get_prices(ticker,startdt = from, enddt = to , interval=interval,exchange_local_time=exchange_local_time,autoadjust=false)
    exch = get_quoteSummary(ticker).price.exchangeName
    scal = get_scaling_factor(interval,exch)
    if in(interval,["1h","90m","60m","30m","15m","5m","2m","1m"])
        # res = AssetPrice(p["close"][isnothing.(p["close"]).==false],p["timestamp"][isnothing.(p["close"]).==false],freq,scal,ticker,_Exchange_Daily_Hours[exch][:name])
        res = AssetPrice(p["close"],p["timestamp"],interval,scal,ticker,_Exchange_Daily_Hours[exch][:name])
    else    
        res = AssetPrice(p["adjclose"],p["timestamp"],interval,scal,ticker,_Exchange_Daily_Hours[exch][:name])
    end
    return res
end

"""
    LogReturn(x::AssetPrice)

Calculates the log return from the price series of the AssetPrice and returns a AssetReturn.
"""
function LogReturn(x::AssetPrice)
    r = log.(x.values[2:end]./x.values[1:end-1])
    LogReturn(r,x.timestamp[2:end],x.freq,x.scale,x.id,x.exchange)
end

"""
    SimpleReturn(x::AssetPrice)

Calculates the simple return from the price series of the AssetPrice and returns a AssetReturn.
"""
function SimpleReturn(x::AssetPrice)
    r = x.values[2:end]./x.values[1:end-1] .-1
    SimpleReturn(r,x.timestamp[2:end],x.freq,x.scale,x.id,x.exchange)
end

"""
    LogReturn(ticker::String,from::TimeType,to::TimeType,interval::String="1d",)

Generates a LogReturn struct. Internally calls AssetPrice and then calculates returns from the price series.

# Arguments
   * ticker the Yahoo Finance ticker
   * from a start time/date (either a `::Date` or `::DateTime`) 
   * to a end time/date (either a `::Date` or `::DateTime`)
   * interval the frequency of data. One of   "3mo","1mo","1wk","5d","1d",1h","90m","60m","30m","15m","5m","2m","1m"
   * exchange_local_time use the local time of the exchange as the timestamp (defaults to true)

# Returns
    LogReturn
"""
function LogReturn(ticker::String,from::TimeType,to::TimeType;interval::String="1d",)
    return LogReturn(AssetPrice(ticker,from,to,interval=interval))
end

"""
    SimpleReturn(ticker::String,from::TimeType,to::TimeType,interval::String)

Generates a SimpleReturn struct. Internally calls AssetPrice and then calculates returns from the price series.

# Arguments
   * ticker the Yahoo Finance ticker
   * from a start time/date (either a `::Date` or `::DateTime`) 
   * to a end time/date (either a `::Date` or `::DateTime`)
   * interval the frequency of data. One of   "3mo","1mo","1wk","5d","1d",1h","90m","60m","30m","15m","5m","2m","1m"
   * exchange_local_time use the local time of the exchange as the timestamp (defaults to true)

# Returns
    SimpleReturn
"""
function SimpleReturn(ticker::String,from::TimeType,to::TimeType;interval::String="1d",)
    return SimpleReturn(AssetPrice(ticker,from,to,interval=interval))
end



function DataFrame(data::AssetPrice)
    if data.freq in ["3mo","1mo","1wk","5d","1d"]
        dates = Date.(data.timestamp)  # Convert DateTime to Date
        prices = round.(data.values, digits=3)  # Extract prices and round
        symbol = data.id
        return DataFrame(ticker = symbol, date = dates, adjclose = prices)
    else
        dates = data.timestamp
        prices = round.(data.values, digits=3)  # Extract prices and round
        symbol = data.id
        return DataFrame(ticker = symbol, timestamp = dates, close = prices)
    end
end

function DataFrame(data::LogReturn)
    if data.freq in ["3mo","1mo","1wk","5d","1d"]
        dates = Date.(data.timestamp)  # Convert DateTime to Date
        returns = round.(data.values, digits=6)  # Extract returns and round to 6 decimals
        symbol = data.id
        interval = data.freq
        type = "log"
        return DataFrame(ticker = symbol, date = dates, interval = interval, type = type, r = returns)
    else
        dates = data.timestamp
        returns = round.(data.values, digits=6)  # Extract returns and round to 6 decimals
        symbol = data.id
        interval = data.freq
        type = "log"
        return DataFrame(ticker = symbol, date = dates, interval = interval, type = type, r = returns)
    end
end

function DataFrame(data::SimpleReturn)
    if data.freq in ["3mo","1mo","1wk","5d","1d"]
        dates = Date.(data.timestamp)  # Convert DateTime to Date
        returns = round.(data.values, digits=6)  # Extract returns and round to 6 decimals
        symbol = data.id
        type = "simple"
        return DataFrame(ticker = symbol, date = dates, interval = interval, type = type, r = returns)
    else
        dates = data.timestamp
        returns = round.(data.values, digits=6)  # Extract returns and round to 6 decimals
        symbol = data.id
        type = "simple"
        return DataFrame(ticker = symbol, date = dates, interval = interval, type = type, r = returns)
    end
end