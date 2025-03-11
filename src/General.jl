"""
    General.jl

Module for retrieving general information from Yahoo Finance.
Provides functions to access quote summaries, financial data, and other company information.
"""

# Constants for Yahoo Finance API
const _QUOTESUMMARY_ITEMS = [
    "assetProfile",
    "balanceSheetHistory",
    "balanceSheetHistoryQuarterly",
    "calendarEvents",
    "cashflowStatementHistory",
    "cashflowStatementHistoryQuarterly",
    "defaultKeyStatistics",
    "earnings",
    "earningsHistory",
    "earningsTrend",
    "esgScores",
    "financialData",
    "fundOwnership",
    "fundPerformance",
    "fundProfile",
    "incomeStatementHistory",
    "incomeStatementHistoryQuarterly",
    "indexTrend",
    "industryTrend",
    "insiderHolders",
    "insiderTransactions",
    "institutionOwnership",
    "majorDirectHolders",
    "majorHoldersBreakdown",
    "netSharePurchaseActivity",
    "price",
    "quoteType",
    "recommendationTrend",
    "secFilings",
    "sectorTrend",
    "summaryDetail",
    "summaryProfile",
    "topHoldings",
    "upgradeDowngradeHistory"
]

"""
    get_quoteSummary(symbol::String; item=nothing, throw_error=false)

Retrieves general information from Yahoo Finance stored in a JSON3 object.

## Arguments

 * `symbol::String` - A ticker symbol (e.g., AAPL for Apple Inc., or ^GSPC for the S&P500)  

 * `item` - Can be either a string or multiple items as a `Vector{String}`. To see valid items call `_QUOTESUMMARY_ITEMS` (not all items are available for all types of securities)
 
 * `throw_error::Bool` - If true, throws an error for invalid symbols; otherwise, returns an empty object and issues a warning

# Examples
```julia-repl
julia> get_quoteSummary("AAPL")
JSON3.Object{Vector{UInt8}, SubArray{UInt64, 1, Vector{UInt64}, Tuple{UnitRange{Int64}}, true}} with 31 entries:
JSON3.Object{Vector{UInt8}, SubArray{UInt64, 1, Vector{UInt64}, Tuple{UnitRange{Int64}}, true}} with 31 entries:
  :assetProfile                      => {…
  :recommendationTrend               => {…
  :cashflowStatementHistory          => {…
  :indexTrend                        => {…
  :defaultKeyStatistics              => {…
 

⋮                         => ⋮
julia> get_quoteSummary("AAPL",item = "quoteType")
JSON3.Object{Vector{UInt8}, SubArray{UInt64, 1, Vector{UInt64}, Tuple{UnitRange{Int64}}, true}} with 13 entries:
julia> get_quoteSummary("AAPL",item = "quoteType")
JSON3.Object{Vector{UInt8}, SubArray{UInt64, 1, Vector{UInt64}, Tuple{UnitRange{Int64}}, true}} with 13 entries:
  :exchange               => "NMS"
  :quoteType              => "EQUITY"
  :symbol                 => "AAPL"
  :underlyingSymbol       => "AAPL"
  :shortName              => "Apple Inc."
  :longName               => "Apple Inc."
  :firstTradeDateEpochUtc => 345479400
  :timeZoneFullName       => "America/New_York"
  :timeZoneShortName      => "EST"
  :uuid                   => "8b10e4ae-9eeb-3684-921a-9ab27e4d87aa"
  :messageBoardId         => "finmb_24937"
  :gmtOffSetMilliseconds  => -18000000
  :maxAge                 => 1
```
"""
function get_quoteSummary(symbol::String; item=nothing,throw_error=false)
    _set_cookies_and_crumb()
    if isequal(_CRUMB,"")
        @warn "This item requires a crumb but a crumb could not be successfully retrieved!"
        return nothing
    end
    
    # Check if symbol is valid
    old_symbol = symbol
    symbol = valid_symbols(symbol)
    if isempty(symbol)
        if throw_error
            error("$old_symbol is not a valid Symbol!")
        else
            @warn "$old_symbol is not a valid Symbol an empty JSON3.Object was returned!" 
            return JSON3.Object()
        end
    else
        symbol = symbol[1]
    end

    if isequal(item, nothing)
        item = _QUOTESUMMARY_ITEMS
    end

    @assert all(in.(item, (_QUOTESUMMARY_ITEMS,))) "At least one item is not a valid option. To view options please call _QUOTESUMMARY_ITEMS"
    
    if typeof(item) <: AbstractString
        q= Dict("formatted" => "false","modules" => item,"crumb"=>_CRUMB)
    else
        q= Dict("formatted" => "false","modules" => join(item,","),"crumb"=>_CRUMB)
    end
    
    res = HTTP.get("https://query2.finance.yahoo.com/v10/finance/quoteSummary/$(symbol)",query =q, proxy=_PROXY_SETTINGS[:proxy],headers=merge(_HEADER,_PROXY_SETTINGS[:auth]),cookies=_COOKIE)    
    res = JSON3.read(res.body)
    if typeof(item) <: AbstractString
        return res.quoteSummary.result[1][Symbol(item)]
    else
        return res.quoteSummary.result[1]
    end
end


#helper Function
function _no_key_missing(x::JSON3.Object,k::Symbol,subitem=nothing,to_date = false,from_int = false)
    if !in(k,keys(x))
        return missing
    end
    if isequal(subitem,nothing)
        if to_date
            return from_int ? unix2datetime(x[k]) : DateTime(x[k])
        else
            return x[k]
        end
    else
        if to_date
            return from_int ? unix2datetime(x[k][subitem]) : DateTime(x[k][subitem])
        else
            return x[k][subitem]
        end
    end

end

function _check_field_quotetype(x)
    d = Dict("ETF" => [:assetProfile,:fundProfile,:summaryDetail,:price,:defaultKeyStatistics,:summaryProfile,:topHoldings,:fundPerformance,:quoteType],
    "MUTUALFUND"=>  [:assetProfile,:fundProfile,:summaryDetail,:price,:esgScores,:defaultKeyStatistics,:summaryProfile,:topHoldings,:fundPerformance,:quoteType],
    "CURRENCY"=> [:summaryDetail,:quoteType,:price],
    "FUTURE"=> [:summaryDetail,:quoteType,:price],
    "EQUITY" => [:assetProfile, :recommendationTrend, :cashflowStatementHistory, :indexTrend, :defaultKeyStatistics, :industryTrend, :quoteType, :incomeStatementHistory, :fundOwnership, :summaryDetail, :insiderHolders, :calendarEvents, :upgradeDowngradeHistory, :price, :balanceSheetHistory, :earningsTrend, :secFilings, :institutionOwnership, :majorHoldersBreakdown, :balanceSheetHistoryQuarterly, :earningsHistory, :majorDirectHolders, :esgScores, :summaryProfile, :netSharePurchaseActivity, :insiderTransactions, :sectorTrend, :incomeStatementHistoryQuarterly, :cashflowStatementHistoryQuarterly, :earnings, :financialData])
    res = String[]
    for (k,v) in d
        if in(x,v)
            push!(res,k)
        end
    end
    return res
end
_quote_type(quoteSummary::JSON3.Object) = quoteSummary.quoteType.quoteType


"""
    get_calendar_events(quoteSummary::JSON3.Object)

Retrieves calendar events from the quote summary.

## Arguments

Can be either a `JSON3.Object` returned from `get_quoteSummary(symbol::String; item=nothing,throw_error=false)` or a ticker symbol of type `AbstractString`
If a ticker symbol is provided `get_quoteSummary(symbol::String)` is called first. 

# Examples
```julia-repl
julia> get_calendar_events("AAPL")
OrderedCollections.OrderedDict{String, Any} with 3 entries:
  "dividend_date"   => DateTime("2025-02-13T00:00:00")
  "earnings_dates"  => [DateTime("2025-04-30T10:59:00"), DateTime("2025-05-05T12:00:00")]
  "exdividend_date" => DateTime("2025-02-10T00:00:00")

julia> using DataFrames
julia> get_calendar_events("AAPL") |> DataFrame
2×3 DataFrame
 Row │ dividend_date        earnings_dates       exdividend_date     
     │ DateTime             DateTime             DateTime            
─────┼───────────────────────────────────────────────────────────────
   1 │ 2025-02-13T00:00:00  2025-04-30T10:59:00  2025-02-10T00:00:00
   2 │ 2025-02-13T00:00:00  2025-05-05T12:00:00  2025-02-10T00:00:00
```
"""
function get_calendar_events(quoteSummary::JSON3.Object, symbol)
    quote_type = _quote_type(quoteSummary)
    field_types = _check_field_quotetype(:calendarEvents)
    @assert in(quote_type,field_types) """Calendar Events dont exist for $(quote_type) items only for $(join(field_types,", "))""" 
    @assert in(:calendarEvents, keys(quoteSummary)) "There are no calendar Events for this item."
    res = OrderedCollections.OrderedDict(
                "symbol" => symbol,
                "dividend_date" => unix2datetime(quoteSummary[:calendarEvents].dividendDate),
                "earnings_dates" => unix2datetime.(quoteSummary[:calendarEvents].earnings.earningsDate),
                "exdividend_date" =>unix2datetime(quoteSummary[:calendarEvents].exDividendDate))
    return res
end
function get_calendar_events(symbol::AbstractString)
    quoteSummary = get_quoteSummary(symbol)
    return get_calendar_events(quoteSummary, symbol)
end

"""
    get_quote_type(quoteSummary::JSON3.Object)
"""
function get_quote_type(quoteSummary::JSON3.Object)
    quote_type = _quote_type(quoteSummary)
    field_types = _check_field_quotetype(:quoteType)
    @assert in(quote_type,field_types) """Quote Type doesn't exist for $(quote_type) items only for $(join(field_types,", "))""" 
    @assert in(:quoteType, keys(quoteSummary)) "There are no Quote Type for this item."
    res = OrderedCollections.OrderedDict(
        "shortName" => quoteSummary[:quoteType].shortName,
        "symbol" => quoteSummary[:quoteType].symbol,
        "underlyingSymbol" => quoteSummary[:quoteType].underlyingSymbol,
        "quoteType" => quoteSummary[:quoteType].quoteType,
        "exchange" => quoteSummary[:quoteType].exchange,
        "firstTrade" => Date(unix2datetime(quoteSummary[:quoteType].firstTradeDateEpochUtc)),
        "timeZone" => quoteSummary[:quoteType].timeZoneShortName,
        "timeZoneLongName" => quoteSummary[:quoteType].timeZoneFullName,
        "gmtOffset" => quoteSummary[:quoteType].gmtOffSetMilliseconds / (1000 * 60 * 60))
    return res
end
get_quote_type(symbol::AbstractString) = get_quoteSummary(symbol) |> get_quote_type

"""
    get_entity_profile(quoteSummary::JSON3.Object, symbol::String)
"""
function get_entity_profile(quoteSummary::JSON3.Object, symbol::String)
    quote_type = _quote_type(quoteSummary)
    field_types = _check_field_quotetype(:summaryProfile)
    @assert in(quote_type,field_types) """Summary Profile doesn't exist for $(quote_type) items only for $(join(field_types,", "))""" 
    @assert in(:quoteType, keys(quoteSummary)) "There is no Summary Profile for this item."
    res = OrderedCollections.OrderedDict(
        "symbol" => symbol,
        "country" => quoteSummary[:summaryProfile].country,
        "sector" => quoteSummary[:summaryProfile].sectorKey,
        "industry" => quoteSummary[:summaryProfile].industryKey,
        "BusinessSummary" => quoteSummary[:summaryProfile].longBusinessSummary,
        "Employees" => quoteSummary[:summaryProfile].fullTimeEmployees,
        "website" => quoteSummary[:summaryProfile].website,
        "irWebsite " => quoteSummary[:summaryProfile].irWebsite)
    return res
end
function get_entity_profile(symbol::AbstractString)
    quoteSummary = get_quoteSummary(symbol)
    return get_entity_profile(quoteSummary, symbol)
end

"""
    get_key_statistics(quoteSummary::JSON3.Object, symbol::String)
"""
function get_key_statistics(quoteSummary::JSON3.Object, symbol::String)
    quote_type = _quote_type(quoteSummary)
    field_types = _check_field_quotetype(:defaultKeyStatistics)
    @assert in(quote_type,field_types) """Key Statistics dont exist for $(quote_type) items only for $(join(field_types,", "))""" 
    @assert in(:quoteType, keys(quoteSummary)) "There are no Key Statistics for this item."
    res = OrderedCollections.OrderedDict(
        "symbol" => symbol,
        "today" => today(),
        "lastFiscalYearEnd" => Date(unix2datetime(quoteSummary[:defaultKeyStatistics].lastFiscalYearEnd)),
        "mostRecentQuarter" => Date(unix2datetime(quoteSummary[:defaultKeyStatistics].mostRecentQuarter)),
        "trailingEps"       => quoteSummary[:defaultKeyStatistics].trailingEps,
        "forwardEps"        => quoteSummary[:defaultKeyStatistics].forwardEps,
        "bookValueps"       => quoteSummary[:defaultKeyStatistics].bookValue,
        "enterpriseToRevenue"       => quoteSummary[:defaultKeyStatistics].enterpriseToRevenue,     
        "enterpriseToEbitda"=> quoteSummary[:defaultKeyStatistics].enterpriseToEbitda,
        "profitMargins"     => quoteSummary[:defaultKeyStatistics].profitMargins, 
        "earningsQuarterlyGrowth"   => quoteSummary[:defaultKeyStatistics].earningsQuarterlyGrowth, 
        "beta"              => quoteSummary[:defaultKeyStatistics].beta,  
        "heldPercentInsiders"       => quoteSummary[:defaultKeyStatistics].heldPercentInsiders,
        "heldPercentInstitutions"   => quoteSummary[:defaultKeyStatistics].heldPercentInstitutions,
        "legalType"         => quoteSummary[:defaultKeyStatistics].legalType,
        "fundFamily"        => quoteSummary[:defaultKeyStatistics].fundFamily)
    return res
end
function get_key_statistics(symbol::AbstractString)
    quoteSummary = get_quoteSummary(symbol)
    return get_key_statistics(quoteSummary, symbol)
end


"""
    get_target_prices(quoteSummary::JSON3.Object)

Retrieves the target price from research analysts.
"""
function get_target_prices(quoteSummary::JSON3.Object, symbol::String)
    quote_type = _quote_type(quoteSummary)
    field_types = _check_field_quotetype(:financialData)
    @assert in(quote_type,field_types) """Target Prices dont exist for $(quote_type) items only for $(join(field_types,", "))""" 
    @assert in(:quoteType, keys(quoteSummary)) "There are no Target Prices for this item."
    res = OrderedCollections.OrderedDict(
        "symbol" => symbol,
        "today" => today(),
        "currentPrice" => quoteSummary[:financialData].currentPrice,
        "targetHighPrice" => quoteSummary[:financialData].targetHighPrice,
        "targetLowPrice" => quoteSummary[:financialData].targetLowPrice,
        "targetMeanPrice" => quoteSummary[:financialData].targetMeanPrice,
        "targetMedianPrice" => quoteSummary[:financialData].targetMedianPrice,
        "numberOfAnalystOpinions" => quoteSummary[:financialData].numberOfAnalystOpinions)
    return res
end
function get_target_prices(symbol::AbstractString)
    quoteSummary = get_quoteSummary(symbol)
    return get_target_prices(quoteSummary, symbol)
end

"""
    get_institutional_ownership(quoteSummary::JSON3.Object)

Retrieves the institutional ownership from the quote summary.

## Arguments

Can be either a `JSON3.Object` returned from `get_quoteSummary(symbol::String; item=nothing,throw_error=false)` or a ticker symbol of type `AbstractString`
If a ticker symbol is provided `get_quoteSummary(symbol::String)` is called first. 

# Examples
```julia-repl
julia> get_institutional_ownership("AAPL")
OrderedDict{String, Vector} with 6 entries:
  "organization" => ["Vanguard Group, Inc. (The)", "Blackrock Inc.", "Berkshire Hathaway,…  
  "reportDate"   => Union{Missing, DateTime}[DateTime("2022-09-30T00:00:00"), DateTime("2…  
  "pctHeld"      => Union{Missing, Float64}[0.08, 0.0641, 0.0562, 0.0372, 0.0221, 0.0176,…  
  "position"     => Union{Missing, Int64}[1272378901, 1020245185, 894802319, 591543874, 3…  
  "value"        => Union{Missing, Int64}[164913030135, 132233979050, 115975329111, 76670…  
  "pctChange"    => Union{Missing, Float64}[-0.0039, -0.0082, 0.0, -0.0111, 0.0191, 0.005…

julia> using DataFrames
julia> get_institutional_ownership("AAPL") |> DataFrame
10×6 DataFrame
 Row │ organization                   reportDate           pctHeld   position    value   ⋯
     │ String                         DateTime?            Float64?  Int64?      Int64?  ⋯
─────┼────────────────────────────────────────────────────────────────────────────────────
   1 │ Vanguard Group, Inc. (The)     2022-09-30T00:00:00    0.08    1272378901  1649130 ⋯
   2 │ Blackrock Inc.                 2022-09-30T00:00:00    0.0641  1020245185  1322339  
   3 │ Berkshire Hathaway, Inc        2022-09-30T00:00:00    0.0562   894802319  1159753  
   4 │ State Street Corporation       2022-09-30T00:00:00    0.0372   591543874   766700  
   5 │ FMR, LLC                       2022-09-30T00:00:00    0.0221   350900116   454801 ⋯
   6 │ Geode Capital Management, LLC  2022-09-30T00:00:00    0.0176   279758518   362595  
   7 │ Price (T.Rowe) Associates Inc  2022-09-30T00:00:00    0.0141   224863541   291445  
   8 │ Morgan Stanley                 2022-09-30T00:00:00    0.0115   182728771   236834  
   9 │ Northern Trust Corporation     2022-09-30T00:00:00    0.0111   176084862   228223 ⋯
  10 │ Bank of America Corporation    2022-09-30T00:00:00    0.0089   142260591   184383  
                                                                         2 columns omitted
```
"""
function get_institutional_ownership(quoteSummary::JSON3.Object, symbol::String)
    quote_type = _quote_type(quoteSummary)
    field_types = _check_field_quotetype(:institutionOwnership)
    @assert in(quote_type, field_types) """Institution Ownership doesn't exist for $(quote_type) items only for $(join(field_types,", "))"""
    @assert in(:quoteType, keys(quoteSummary)) "There is no Institution Ownership for this item."
    
    # Create a vector of OrderedDicts, one for each institution
    result = []
    
    # Process each entry in the ownershipList
    for ownership in quoteSummary[:institutionOwnership].ownershipList
        institution = OrderedCollections.OrderedDict(
            "symbol" => symbol,
            "organization" => ownership.organization,
            "reportDate" => Date(unix2datetime(ownership.reportDate.raw)),
            "pctHeld" => ownership.pctHeld.raw,
            "position" => ownership.position.raw,
            "value" => ownership.value.raw,
            "pctChange" => ownership.pctChange.raw
        )
        push!(result, institution)
    end
    return result
end
function get_institutional_ownership(symbol::AbstractString)
    quoteSummary = get_quoteSummary(symbol)
    return get_institutional_ownership(quoteSummary, symbol)
end

"""
    function get_fund_ownership(quoteSummary::JSON3.Object, symbol::String)

Retrieves fund ownership from the quote summary.
"""
function get_fund_ownership(quoteSummary::JSON3.Object, symbol::String)
    quote_type = _quote_type(quoteSummary)
    field_types = _check_field_quotetype(:fundOwnership)
    @assert in(quote_type, field_types) """Fund Ownership doesn't exist for $(quote_type) items only for $(join(field_types,", "))"""
    @assert in(:quoteType, keys(quoteSummary)) "There is no Fund Ownership for this item."
    
    # Create a vector of OrderedDicts, one for each institution
    result = []
    
    # Process each entry in the ownershipList
    for ownership in quoteSummary[:fundOwnership].ownershipList
        fund = OrderedCollections.OrderedDict(
            "symbol" => symbol,
            "organization" => ownership.organization,
            "reportDate" => Date(unix2datetime(ownership.reportDate.raw)),
            "pctHeld" => ownership.pctHeld.raw,
            "position" => ownership.position.raw,
            "value" => ownership.value.raw,
            "pctChange" => ownership.pctChange.raw
        )
        push!(result, fund)
    end
    return result
end
function get_fund_ownership(symbol::AbstractString)
    quoteSummary = get_quoteSummary(symbol)
    return get_fund_ownership(quoteSummary, symbol)
end


"""
    get_eps_estimates(quoteSummary::JSON3.Object, symbol::String)

Retrieves the earnings estimates from the quote summary.

## Arguments

Can be either a `JSON3.Object` returned from `get_quoteSummary(symbol::String; item=nothing,throw_error=false)` or a ticker symbol of type `AbstractString`
If a ticker symbol is provided `get_quoteSummary(symbol::String)` is called first. 

# Examples
```julia-repl
julia> get_eps_estimates("AAPL")
OrderedDict{String, Vector} with 3 entries:
  "quarter"  => ["4Q2021", "1Q2022", "2Q2022", "3Q2022", "4Q2022"]
  "estimate" => [1.89, 1.43, 1.16, 1.27, 1.98]
  "actual"   => Union{Missing, Float64}[2.1, 1.52, 1.2, 1.29, missing]

julia> using DataFrames
julia> get_eps_estimates("AAPL") |> DataFrame
5×3 DataFrame
 Row │ quarter  estimate  actual     
     │ String   Float64   Float64?   
─────┼───────────────────────────────
   1 │ 1Q2024    1.49923        1.53
   2 │ 2Q2024    1.34086        1.4
   3 │ 3Q2024    0.94654        0.97
   4 │ 4Q2024    2.34102        2.4
   5 │ 1Q2025    1.60796  missing     
```
"""
function get_eps_estimates(quoteSummary::JSON3.Object, symbol::String)
    quote_type = _quote_type(quoteSummary)
    field_types = _check_field_quotetype(:earnings)
    @assert in(quote_type,field_types) """EPS dont exist for $(quote_type) items only for $(join(field_types,", "))""" 
    @assert in(:earnings, keys(quoteSummary)) "There are no EPS for this item."
    if isempty(quoteSummary[:earnings].earningsChart.quarterly)
        return OrderedCollections.OrderedDict()
    end

    quarter = String[]
    actual = Union{Missing,Float64}[]
    estimate = Float64[]
    for i in quoteSummary[:earnings].earningsChart.quarterly
        push!(quarter,i.date)
        push!(actual,i.actual)
        push!(estimate,i.estimate)
    end
    
    quoteSummary[:earnings].earningsChart
    push!(quarter,string(quoteSummary[:earnings].earningsChart.currentQuarterEstimateDate,quoteSummary[:earnings].earningsChart.currentQuarterEstimateYear))
    push!(actual,missing)
    push!(estimate, quoteSummary[:earnings].earningsChart.currentQuarterEstimate)
    return OrderedCollections.OrderedDict(["symbol", "quarter","epsEstimate","epsActual"] .=> [symbol, quarter,estimate,actual])
end
function get_eps_estimates(symbol::AbstractString)
    quoteSummary = get_quoteSummary(symbol)
    return get_eps_estimates(quoteSummary, symbol)
end


"""
    get_insider_holders(quoteSummary::JSON3.Object)

Retrieves the insider holdings from the quote summary.

## Arguments

Can be either a `JSON3.Object` returned from `get_quoteSummary(symbol::String; item=nothing,throw_error=false)` or a ticker symbol of type `AbstractString`
If a ticker symbol is provided `get_quoteSummary(symbol::String)` is called first. 

# Examples
```julia-repl
julia> get_insider_holders("AAPL")
OrderedCollections.OrderedDict{String, Vector} with 8 entries:
  "name"                 => ["ADAMS KATHERINE L", "AUSTIN WANDA M", "GORSKY ALEX", "JUNG ANDREA", "K…
  "relation"             => Union{Missing, String}["General Counsel", "Director", "Director", "Director",…
  "description"          => Union{Missing, String}["Stock Gift", "Conversion of Exercise of derivative security", "Con…
  "lastestTransDate"     => Union{Missing, DateTime}[DateTime("2024-11-05T00:00:00"), DateTime("2025-01-31T00:00:00"),Date…
  "positionDirect"       => Union{Missing, Int64}[179043, 1588, 5539, 76005, 15419, 4215580, 8607, 109311, 68533, missing]
  "positionDirectDate"   => Union{Missing, DateTime}[DateTime("2024-11-05T00:00:00"), DateTime("2025-01-31T00:00:00"),Date…
  "positionIndirect"     => Union{Missing, Int64}[missing, missing, missing, missing, missing, missing, missing, missing,…
  "positionIndirectDate" => Union{Missing, DateTime}[missing, missing, missing, missing, missing, missing, missing, DateT…


julia> using DataFrames
julia> get_insider_holders("AAPL") |> DataFrame
10×8 DataFrame
 Row │ name                relation                 description                        lastestTransDate     positionDir⋯
     │ String              String?                  String?                            DateTime?            Int64?   ⋯
─────┼─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
   1 │ ADAMS KATHERINE L   General Counsel          Stock Gift                         2024-11-05T00:00:00          179⋯
   2 │ AUSTIN WANDA M      Director                 Conversion of Exercise of deriva…  2025-01-31T00:00:00            1588
   3 │ GORSKY ALEX         Director                 Conversion of Exercise of deriva…  2025-01-31T00:00:00            5539 
   4 │ JUNG ANDREA         Director                 Conversion of Exercise of deriva…  2025-01-31T00:00:00           76005 
   5 │ KONDO CHRISTOPHER   Officer                  Sale                               2024-11-18T00:00:00           15419 
   6 │ LEVINSON ARTHUR D   Director                 Sale                               2025-02-03T00:00:00         4215580
   7 │ LOZANO MONICA C.    Director                 Conversion of Exercise of deriva…  2025-01-31T00:00:00            8607 
   8 │ SUGAR RONALD D      Director                 Conversion of Exercise of deriva…  2025-01-31T00:00:00          109311
   9 │ WAGNER SUSAN L      Director                 Conversion of Exercise of deriva…  2025-01-31T00:00:00           68533
  10 │ WILLIAMS JEFFREY E  Chief Operating Officer  Sale                               2024-12-16T00:00:00         missing
                                                             3 columns and 1 row omitted
```
"""
function get_insider_holders(quoteSummary::JSON3.Object)
    quote_type = _quote_type(quoteSummary)
    field_types = _check_field_quotetype(:insiderHolders)
    @assert in(quote_type,field_types) """Insider Holdings dont exist for $(quote_type) items only for $(join(field_types,", "))""" 
    @assert in(:insiderHolders, keys(quoteSummary)) "There are is no insiderHolders item."
    if isempty(quoteSummary[:insiderHolders].holders)
        return OrderedCollections.OrderedDict()
    end
    get_valuation("AAPL", "quarter", "2023-06-30", today())
    name = String[]
    relation = Union{Missing,String}[]
    des = Union{Missing,String}[]
    lasttrandt = Union{Missing,DateTime}[]
    direct = Union{Missing,Int}[]
    direct_dt = Union{Missing,DateTime}[]
    indirect = Union{Missing,Int}[]
    indirect_dt = Union{Missing,DateTime}[]
    for i in quoteSummary[:insiderHolders].holders
        push!(name, i.name)
        push!(relation, _no_key_missing(i,:relation))
        push!(des, _no_key_missing(i,:transactionDescription))
        push!(lasttrandt, _no_key_missing(i,:latestTransDate,:fmt,true))
        push!(direct, _no_key_missing(i,:positionDirect,:raw))
        push!(direct_dt,_no_key_missing(i,:positionDirectDate,:fmt,true))
        push!(indirect,_no_key_missing(i,:positionIndirect,:raw))
        push!(indirect_dt, _no_key_missing(i,:positionIndirectDate,:fmt,true))
    end
    res = OrderedCollections.OrderedDict(["name","relation","description","lastestTransDate","positionDirect",
                "positionDirectDate","positionIndirect","positionIndirectDate"] .=> 
               [name, relation,des,lasttrandt,direct,direct_dt,indirect,indirect_dt])
    return res
end
get_insider_holders(symbol::AbstractString) =  get_quoteSummary(symbol) |> get_insider_holders


"""
    get_insider_transactions(quoteSummary::JSON3.Object)

Retrievs the insider transactions from the quote summary.

## Arguments

Can be either a `JSON3.Object` returned from `get_quoteSummary(symbol::String; item=nothing,throw_error=false)` or a ticker symbol of type `AbstractString`
If a ticker symbol is provided `get_quoteSummary(symbol::String)` is called first. 

# Examples
```julia-repl
julia> get_insider_transactions("AAPL")
OrderedDict{String, Vector} with 7 entries:
  "filerName"       => ["KONDO CHRISTOPHER", "MAESTRI LUCA", "O'BRIEN DEIRDRE", "KONDO CH…  
  "filerRelation"   => Union{Missing, String}["Officer", "Chief Financial Officer", "Offi…  
  "transactionText" => Union{Missing, String}["Sale at price 148.72 per share.", "Sale at…  
  "date"            => Union{Missing, DateTime}[DateTime("2022-11-22T00:00:00"), DateTime…  
  "ownership"       => Union{Missing, String}["D", "D", "D", "D", "D", "D", "D", "D", "I"…  
  "shares"          => Union{Missing, Int64}[20200, 176299, 8053, 13136, 16612, 181139, 1…  
  "value"           => Union{Missing, Int64}[3004144, 27493275, 1147150, missing, missing…

julia> using DataFrames
julia> get_insider_transactions("AAPL") |> DataFrame
75×7 DataFrame
 Row │ filerName           filerRelation            transactionText                    d ⋯
     │ String              String?                  String?                            D ⋯
─────┼────────────────────────────────────────────────────────────────────────────────────
   1 │ KONDO CHRISTOPHER   Officer                  Sale at price 148.72 per share.    2 ⋯
   2 │ MAESTRI LUCA        Chief Financial Officer  Sale at price 154.70 - 157.20 pe…  2  
   3 │ O'BRIEN DEIRDRE     Officer                  Sale at price 142.45 per share.    2  
   4 │ KONDO CHRISTOPHER   Officer                                                     2  
   5 │ O'BRIEN DEIRDRE     Officer                                                     2 ⋯   
   6 │ ADAMS KATHERINE L   General Counsel          Sale at price 138.44 - 142.93 pe…  2  
   7 │ O'BRIEN DEIRDRE     Officer                  Sale at price 141.09 - 142.83 pe…  2  
  ⋮  │         ⋮                      ⋮                             ⋮                    ⋱
  70 │ WAGNER SUSAN L      Director                                                    2  
  71 │ JUNG ANDREA         Director                                                    2 ⋯
  72 │ BELL JAMES A        Director                                                    2  
  73 │ LOZANO MONICA C.    Director                                                    2  
  74 │ GORE ALBERT A JR    Director                                                    2  
  75 │ ADAMS KATHERINE L   General Counsel          Sale at price 131.79 - 134.56 pe…  2 ⋯
                                                             4 columns and 62 rows omitted
```
"""
function get_insider_transactions(quoteSummary::JSON3.Object)
    quote_type = _quote_type(quoteSummary)
    field_types = _check_field_quotetype(:insiderTransactions)
    @assert in(quote_type,field_types) """Insider Transactions dont exist for $(quote_type) items only for $(join(field_types,", "))""" 
    @assert in(:insiderTransactions, keys(quoteSummary)) "There are is no insiderTransactions item."
    if isempty(quoteSummary[:insiderTransactions].transactions)
        return OrderedCollections.OrderedDict()
    end

    name = String[]
    relation = Union{Missing,String}[]
    text = Union{Missing,String}[]
    date = Union{Missing,DateTime}[]
    ownership = Union{Missing,String}[]
    shares = Union{Missing,Int}[]
    value = Union{Missing,Int}[]
    for i in quoteSummary[:insiderTransactions].transactions
        push!(name, i.filerName)
        push!(relation, _no_key_missing(i,:filerRelation))
        push!(text, _no_key_missing(i,:transactionText))
        push!(date, _no_key_missing(i,:startDate,:fmt,true))
        push!(ownership, _no_key_missing(i,:ownership))
        push!(shares,_no_key_missing(i,:shares,:raw))
        push!(value,_no_key_missing(i,:value,:raw))
    end
    res = OrderedCollections.OrderedDict(["filerName","filerRelation","transactionText","date","ownership",
                "shares","value"] .=> 
               [name, relation,text,date,ownership,shares,value])
    return res
end
get_insider_transactions(symbol::AbstractString) =  get_quoteSummary(symbol) |> get_insider_transactions


"""
    get_recommendation_trend(quoteSummary::JSON3.Object)

Retrievs the recommendation trend from the quote summary.

## Arguments

Can be either a `JSON3.Object` returned from `get_quoteSummary(symbol::String; item=nothing,throw_error=false)` or a ticker symbol of type `AbstractString`
If a ticker symbol is provided `get_quoteSummary(symbol::String)` is called first. 

# Examples
```julia-repl
julia> get_recommendation_trend("AAPL")
OrderedCollections.OrderedDict{String, Vector} with 6 entries:
  "period"     => ["0m", "-1m", "-2m"]
  "strongbuy"  => [7, 8, 8]
  "buy"        => [21, 21, 24]
  "hold"       => [13, 13, 12]
  "sell"       => [2, 2, 1]
  "strongsell" => [2, 2, 2]
  
julia> using DataFrames
jjulia> get_recommendation_trend("AAPL") |> DataFrame
3×6 DataFrame
 Row │ period  strongbuy  buy    hold   sell   strongsell 
     │ String  Int64      Int64  Int64  Int64  Int64      
─────┼────────────────────────────────────────────────────
   1 │ 0m              7     21     13      2           2
   2 │ -1m             8     21     13      2           2
   3 │ -2m             8     24     12      1           2
```
"""
function get_recommendation_trend(quoteSummary::JSON3.Object, symbol::String)
    quote_type = _quote_type(quoteSummary)
    field_types = _check_field_quotetype(:recommendationTrend)
    @assert in(quote_type,field_types) """The recommendation trend does not exist for $(quote_type) items only for $(join(field_types,", "))""" 
    @assert in(:recommendationTrend, keys(quoteSummary)) "There are is no recommendationTrend item."
    if isempty(quoteSummary[:recommendationTrend].trend)
        return OrderedCollections.OrderedDict()
    end

    period = String[]
    strongbuy = Int[]
    buy = Int[]
    hold = Int[]
    sell = Int[]
    strongsell = Int[]
    for i in quoteSummary[:recommendationTrend].trend
        push!(period, i.period)
        push!(strongbuy, i.strongBuy)
        push!(buy, i.buy)
        push!(hold, i.hold)
        push!(sell, i.sell)
        push!(strongsell, i.strongSell)
    end
    res = OrderedCollections.OrderedDict(["symbol","today","period","strongbuy","buy","hold","sell",
                "strongsell"] .=> 
               [symbol,today(),period,strongbuy,buy,hold,sell,strongsell])
    return res
end
function get_recommendation_trend(symbol::AbstractString)
    quoteSummary = get_quoteSummary(symbol)
    return get_recommendation_trend(quoteSummary, symbol)
end

"""
    get_summary_detail(quoteSummary::JSON3.Object)

Retrievs the summaryDetail Item from the quote summary.

## Arguments

Can be either a `JSON3.Object` returned from `get_quoteSummary(symbol::String; item=nothing,throw_error=false)` or a ticker symbol of type `AbstractString`
If a ticker symbol is provided `get_quoteSummary(symbol::String)` is called first. 

# Examples
```julia-repl
julia> get_summary_detail("AAPL")
OrderedCollections.OrderedDict{String, Any} with 41 entries:
  "priceHint"                    => 2
  "previousClose"                => 237.3
  "open"                         => 236.95
  "dayLow"                       => 234.51
  "dayHigh"                      => 242.09
  "regularMarketPreviousClose"   => 237.3
  "regularMarketOpen"            => 236.95
  "regularMarketDayLow"          => 234.51
  "regularMarketDayHigh"         => 242.09
  "dividendRate"                 => 1
  "dividendYield"                => 0.0041
  "exDividendDate"               => 1739145600
  "payoutRatio"                  => 0.1571
  "fiveYearAvgDividendYield"     => 0.59
  "beta"                         => 1.2
  "trailingPE"                   => 38.2559
  "forwardPE"                    => 29.0487
  "volume"                       => 56833360
  "regularMarketVolume"          => 56833360
  "averageVolume"                => 50717047
  "averageVolume10days"          => 44916030
  "averageDailyVolume10Day"      => 44916030
  "bid"                          => 229.91
  "ask"                          => 242.62
  "bidSize"                      => 100
  "askSize"                      => 200
  "marketCap"                    => 3626259972096
  "fiftyTwoWeekLow"              => 164.08
  "fiftyTwoWeekHigh"             => 260.1
  "priceToSalesTrailing12Months" => 9.16277
  "fiftyDayAverage"              => 240.221
"""
function get_summary_detail(quoteSummary::JSON3.Object)
    quote_type = _quote_type(quoteSummary)
    field_types = _check_field_quotetype(:summaryDetail)
    @assert in(quote_type,field_types) """Summary details dont exist for $(quote_type) items only for $(join(field_types,", "))""" 
    @assert in(:summaryDetail, keys(quoteSummary)) "There are is no summaryDetail item."
    result = OrderedCollections.OrderedDict(String(k) => v for (k , v) in quoteSummary.summaryDetail)
    delete!(result,"maxAge")
    return result    
end
get_summary_detail(symbol::AbstractString) =  get_quoteSummary(symbol) |> get_summary_detail


"""
    get_upgrade_downgrade_history(quoteSummary::JSON3.Object)

Retrieves the upgrade and downgrade history from the quote summary.

## Arguments

Can be either a `JSON3.Object` returned from `get_quoteSummary(symbol::String; item=nothing,throw_error=false)` or a ticker symbol of type `AbstractString`
If a ticker symbol is provided `get_quoteSummary(symbol::String)` is called first. 

# Examples
```julia-repl
julia> get_upgrade_downgrade_history("AAPL")
OrderedDict{String, Vector} with 5 entries:
  "firm"      => ["JP Morgan", "UBS", "Morgan Stanley", "B of A Securities", "Barclays", …  
  "date"      => Union{Missing, DateTime}[DateTime("2022-12-20T11:47:33"), DateTime("2022…  
  "toGrade"   => Union{Missing, String}["Overweight", "Buy", "Overweight", "Neutral", "Eq…  
  "fromGrade" => Union{Missing, String}["", "", "", "", "", "", "", "", "", ""  …  "", ""…  
  "action"    => Union{Missing, String}["main", "main", "main", "main", "main", "main", "…
  
julia> using DataFrames
julia> get_upgrade_downgrade_history("AAPL") |> DataFrame
872×5 DataFrame
 Row │ firm               date                 toGrade       fromGrade  action  
     │ String             DateTime?            String?       String?    String? 
─────┼──────────────────────────────────────────────────────────────────────────
   1 │ JP Morgan          2022-12-20T11:47:33  Overweight               main
   2 │ UBS                2022-11-08T12:17:03  Buy                      main
   3 │ Morgan Stanley     2022-11-08T12:14:23  Overweight               main
   4 │ B of A Securities  2022-11-07T13:08:30  Neutral                  main
   5 │ Barclays           2022-11-07T12:39:27  Equal-Weight             main
   6 │ Wedbush            2022-10-28T13:19:17  Outperform               main
   7 │ Credit Suisse      2022-10-28T11:59:30  Outperform               main
  ⋮  │         ⋮                   ⋮                ⋮            ⋮         ⋮
 867 │ Oxen Group         2012-03-14T15:25:00  Buy                      init
 868 │ Canaccord Genuity  2012-03-14T08:21:00  Buy                      main
 869 │ Morgan Stanley     2012-03-14T06:13:00  Overweight               main
 870 │ Jefferies          2012-03-13T06:08:00  Buy                      main
 871 │ FBN Securities     2012-03-08T07:33:00  Outperform               main
 872 │ Canaccord Genuity  2012-02-09T08:17:00  Buy                      main
                                                                859 rows omitted
```
"""
function get_upgrade_downgrade_history(quoteSummary::JSON3.Object, symbol::String)
    quote_type = _quote_type(quoteSummary)
    field_types = _check_field_quotetype(:upgradeDowngradeHistory)
    @assert in(quote_type,field_types) """The history of up- and downgrades does not exist for $(quote_type) items only for $(join(field_types,", "))""" 
    @assert in(:upgradeDowngradeHistory, keys(quoteSummary)) "There are is no upgradeDowngradeHistory item."
    if isempty(quoteSummary[:upgradeDowngradeHistory].history)
        return OrderedCollections.OrderedDict()
    end

    firm = String[]
    date = Union{Missing,DateTime}[]
    toGrade = Union{Missing,String}[]
    fromGrade = Union{Missing,String}[]
    action = Union{Missing,String}[]
    for i in quoteSummary[:upgradeDowngradeHistory].history
        push!(firm, i.firm)
        push!(date, _no_key_missing(i,:epochGradeDate,nothing,true,true))
        push!(toGrade, _no_key_missing(i,:toGrade))
        push!(fromGrade, _no_key_missing(i,:fromGrade))
        push!(action, _no_key_missing(i,:action))
    end
    res = OrderedCollections.OrderedDict(["symbol","firm","date","toGrade","fromGrade","action"] .=> 
               [symbol,firm,date,toGrade,fromGrade,action])
    return res
end
function get_upgrade_downgrade_history(symbol::AbstractString)
    quoteSummary = get_quoteSummary(symbol)
    return get_upgrade_downgrade_history(quoteSummary, symbol)
end

"""
    get_sec_filings(quoteSummary::JSON3.Object, symbol::String)
"""
function get_sec_filings(quoteSummary::JSON3.Object, symbol::String)
    quote_type = _quote_type(quoteSummary)
    field_types = _check_field_quotetype(:secFilings)
    @assert in(quote_type, field_types) """SEC Filings doesn't exist for $(quote_type) items only for $(join(field_types,", "))"""
    @assert in(:quoteType, keys(quoteSummary)) "There are no SEC Filings for this item."
    
    # Initialize with explicit key-value pairs for all possible columns
    result = OrderedDict{String, Union{String, Int64, Missing, Date}}[]
    
    for filing in quoteSummary[:secFilings].filings
        # Convert epochDate to Date if present
        # Base filing with ALL potential columns initialized to missing
        base_filing = OrderedDict{String, Union{String, Int64, Missing, Date}}(
            "symbol" => symbol,
            "date" => Date(get(filing, :date, missing)),
            "type" => get(filing, :type, missing),
            "title" => get(filing, :title, missing),
            "edgarUrl" => get(filing, :edgarUrl, missing),
            "exhibit_type" => missing,  # Explicitly initialized
            "exhibit_url" => missing,
            "exhibit_downloadUrl" => missing
        )
        
        if !haskey(filing, :exhibits) || isempty(filing.exhibits)
            push!(result, base_filing)
            continue
        end
        
        for exhibit in filing.exhibits
            filing_with_exhibit = copy(base_filing)
            filing_with_exhibit["exhibit_type"] = get(exhibit, :type, missing)
            filing_with_exhibit["exhibit_url"] = get(exhibit, :url, missing)
            filing_with_exhibit["exhibit_downloadUrl"] = get(exhibit, :downloadUrl, missing)
            push!(result, filing_with_exhibit)
        end
    end
    return result
end
function get_sec_filings(symbol::AbstractString)
    quoteSummary = get_quoteSummary(symbol)
    return get_sec_filings(quoteSummary, symbol)
end


"""
    get_ESG(symbol::String)

Retrieves ESG Scores, containing (i) the company ESG scores as well as (ii) the peer group's scores.

# Arguments

 * symbol`::String` is a ticker (e.g. "AAPL" for Apple Computers)  
```
"""
function get_esg_scores(symbol::String)

     # Check if symbol is valid
     old_symbol = symbol
     symbol = valid_symbols(symbol)
     if isempty(symbol)
             @warn "$old_symbol is not a valid Symbol an empy OrderedCollections.OrderedDict was returned!" 
             return OrderedCollections.OrderedDict()
     else
         symbol = symbol[1]
     end

    q = Dict("symbol" =>symbol)
    function nothingtomissing(x::Any)
        return x
    end
    function nothingtomissing(x::Nothing)
        return missing
    end    
    res = HTTP.get("https://query2.finance.yahoo.com/v1/finance/esgChart",query =q, proxy=_PROXY_SETTINGS[:proxy],headers=_PROXY_SETTINGS[:auth])   
    res = JSON3.read(res.body)
    res = res.esgChart.result[1]
    self = OrderedCollections.OrderedDict(
        "symbol" => symbol,
        "date"=>Date.(unix2datetime.(res.symbolSeries.timestamp)),
        "esgScore"=>nothingtomissing.(res.symbolSeries.esgScore),
        "governanceScore"=>nothingtomissing.(res.symbolSeries.governanceScore),
        "environmentScore"=>nothingtomissing.(res.symbolSeries.environmentScore),
        "socialScore"=>nothingtomissing.(res.symbolSeries.socialScore),
        "esgScorePeers"=>nothingtomissing.(res.peerSeries.esgScore),
        "governanceScorePeers"=>nothingtomissing.(res.peerSeries.governanceScore),
        "environmentScorePeers"=>nothingtomissing.(res.peerSeries.environmentScore),
        "socialScorePeers"=>nothingtomissing.(res.peerSeries.socialScore))
    return self
end


function db_create_insert(conn, table_name::String, df::DataFrame)
    # Register df as a virtual table
    DuckDB.register_data_frame(conn, df, "virtual") 
    
    if table_exists(conn, table_name)
        # Get all column names of the target table
        columns = get_table_columns(conn, table_name)
        
        # Construct the WHERE NOT EXISTS clause dynamically
        where_clause = join(["$table_name.$col = virtual.$col" for col in columns], " AND ")
        
        # Construct the final INSERT query
        query = """
            INSERT INTO $table_name
            SELECT * FROM virtual
            WHERE NOT EXISTS (
                SELECT 1 FROM $table_name
                WHERE $where_clause
            );
        """
        
        # Execute the query
        DBInterface.execute(conn, query)
        println("\n✅ Table '$(table_name)' updated, ignoring duplicate rows.")
    else
        # If the table doesn't exist, create it
        DBInterface.execute(conn, "CREATE TABLE $table_name AS SELECT * FROM virtual;")
        # Print a summary message for table creation
        println("\n✅ Table '$(table_name)' created with $(nrow(df)) rows.")
    end
    
    # Clean up the virtual table
    DBInterface.execute(conn, "DROP VIEW IF EXISTS virtual;")
end

function table_exists(conn::DuckDB.DB, table_name::String)
    result = DBInterface.execute(conn, 
        "SELECT 1 FROM information_schema.tables WHERE table_name = '$table_name';") |> collect
    return !isempty(result)  # Returns true if the table exists, false otherwise
end

function get_table_columns(conn::DuckDB.DB, table_name::String)
    # Query to get all column names of the table
    result = DBInterface.execute(conn, 
        "SELECT column_name FROM information_schema.columns WHERE table_name = '$table_name';") |> DataFrame
    return result.column_name
end
