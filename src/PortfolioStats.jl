# Measures of total and loss risk. 
# Measures of market performance 

################################
# Drawdowns:
function drawdowns(prices::Vector{Union{Missing, Float64}})
    n = length(prices)
    drawdowns = zeros(n)
    peak = prices[1]  # Start with the first price as peak
    for i in 2:n
        peak = max(peak, prices[i])  # Update peak if new high
        drawdowns[i] = (prices[i] - peak) / peak  # Compute drawdown
    end
    return abs.(drawdowns)  # Return positive drawdowns
end

function drawdown_metrics(prices::Vector{Union{Missing, Float64}})
    n = length(prices)
    peak = prices[1]  # Start with first price as peak
    drawdowns = zeros(n)
    drawdown_durations = zeros(Int, n)
    max_drawdown = 0.0
    last_peak_idx = 1

    for i in 1:n
        if prices[i] > peak
            peak = prices[i]
            last_peak_idx = i
        end

        drawdowns[i] = (prices[i] - peak) / peak  # Compute drawdown percentage
        max_drawdown = min(max_drawdown, drawdowns[i])  # Update max drawdown
        
        # Compute drawdown duration (days since last peak)
        drawdown_durations[i] = i - last_peak_idx
    end
    return abs.(drawdowns), abs(max_drawdown), abs(mean(drawdowns)), drawdown_durations
end

function drawdown_table(x::Vector{Union{Missing, Float64}}, dates::Vector{<:TimeType})
    length(x) == length(dates) || error("Prices and dates must have the same length.")

    peak = x[1]
    max_dd = 0.0
    start_idx = 1
    min_idx = 1
    drawdowns = []

    for i in 2:length(x)
        if x[i] > peak
            # Record drawdown if we were in a drawdown and recovered
            if max_dd < 0
                push!(drawdowns, (max_dd, start_idx, min_idx, i-1, dates[i-1] - dates[start_idx]))
            end
            # Reset for next drawdown
            peak = x[i]
            start_idx = i
            max_dd = 0.0
        else
            dd = (x[i] - peak) / peak  # Drawdown as a simple return
            if dd < max_dd
                max_dd = dd
                min_idx = i
            end
        end
    end

    # If we end in a drawdown, record it
    if max_dd < 0
        push!(drawdowns, (max_dd, start_idx, min_idx, length(x), dates[end] - dates[start_idx]))
    end

    # Convert to DataFrame
    df = DataFrame(
        Depth = [-d[1] for d in drawdowns],  # Drawdown depth (sorted later)
        Start_Date = [dates[d[2]] for d in drawdowns],  # Start date
        Max_Date = [dates[d[3]] for d in drawdowns],  # Date of max drawdown
        End_Date = [dates[d[4]] for d in drawdowns],  # End date
        Duration = [d[5].value for d in drawdowns]  # Duration in days
    )
    sort!(df, :Depth, rev = true) # Sort by Depth (largest drawdown first)
    return df
end


"""
    max_drawdown(returns::Vector{Float64})
"""
function max_drawdown(returns::Vector{Union{Missing, Float64}})
    cumulative_returns = cumsum(returns)  # Compute cumulative log returns
    peak = accumulate(max, cumulative_returns)  # Running max
    drawdown = cumulative_returns .- peak  # Drawdown in log terms
    return abs(minimum(drawdown))  # Maximum drawdown in absolute terms
end

"""
    calmarratio(log_returns::Vector{Float64}; trading_days=252)
"""
function calmarratio(log_returns::Vector{Union{Missing, Float64}}; trading_days=252)
    n = length(log_returns)  # Number of periods
    ann_ret = sum(log_returns) * (trading_days / n)  # Annualized log return
    mdd = max_drawdown(log_returns)  # Maximum drawdown
    return ann_ret / mdd  # Calmar Ratio
end
"""
    sharperatio(R::Number,σ::Number,Rf::Number=0.;scale=1)

Calculates the Sharpe Ratio from a given return, standard deviation, and risk free rate.

```math
SR=\\frac{r_a - r_f}{\\sigma_a}
```
"""
sharperatio(R::Number,σ::Number,Rf::Number) = (R-Rf)/σ

"""
    sharperatio(R::AbstractArray{<:Number},Rf::Number=0.;scale)

Calculates the Sharpe Ratio from a given return series and a risk free rate.
"""
function sharperatio(R::Vector{Union{Missing, Float64}},Rf::Number)
    σ = std(R)
    μ = mean(R)
    return sharperatio(μ,σ,Rf)
end



function VaR(sigma::Real, alpha::Real, dist::Distribution, mu::Real=0)
    q = quantile(dist, alpha)
    VaR = -(mu + sigma * q)
    return VaR
end

function VaR(returns::Vector{Union{Missing, Float64}}, alpha::Real, dist::Distribution, mu::Real=0)
    sigma = std(returns)
    q = quantile(dist, alpha)
    VaR = -(mu + sigma * q)
    return VaR
end

function ETL(sigma::Real, alpha::Real, dist::Distribution, mu::Real=0)
    q = quantile(dist, alpha)
    if dist isa Normal
        ETL = -mu + sigma * pdf(dist, q) / alpha  
    elseif dist isa TDist
        v = dist.ν
        t_pdf = pdf(dist, q) 
        ETL = -mu + sigma * (t_pdf / alpha) * (v + q^2) / (v - 1)
    else # Numerical integration fallback
        E_X_cond, _ = quadgk(x -> x * pdf(dist, x), -Inf, q)
        ETL = -(mu + sigma * (E_X_cond / alpha))
    end
    return ETL
end

function ETL(returns::Vector{Union{Missing, Float64}}, alpha::Real, dist::Distribution, mu::Real=0)
    sigma = std(returns)
    q = quantile(dist, alpha)
    if dist isa Normal
        ETL = -mu + sigma * pdf(dist, q) / alpha  
    elseif dist isa TDist
        v = dist.ν
        t_pdf = pdf(dist, q) 
        ETL = -mu + sigma * (t_pdf / alpha) * (v + q^2) / (v - 1)
    else # Numerical integration fallback
        E_X_cond, _ = quadgk(x -> x * pdf(dist, x), -Inf, q)
        ETL = -(mu + sigma * (E_X_cond / alpha))
    end
    return ETL
end


function VaR_ETL(sigma::Real, alpha::Real, dist::Distribution, mu::Real=0)
    q = quantile(dist, alpha)
    VaR = -(mu + sigma * q)
    if dist isa Normal
        ETL = -mu + sigma * pdf(dist, q) / alpha  
    elseif dist isa TDist
        v = dist.ν
        t_pdf = pdf(dist, q) 
        ETL = -mu + sigma * (t_pdf / alpha) * (v + q^2) / (v - 1)
    else # Numerical integration fallback
        E_X_cond, _ = quadgk(x -> x * pdf(dist, x), -Inf, q)
        ETL = -(mu + sigma * (E_X_cond / alpha))
    end
    return VaR, ETL
end

function VaR_ETL(returns::Vector{Union{Missing, Float64}}, alpha::Real, dist::Distribution, mu::Real=0)
    sigma = std(returns)
    q = quantile(dist, alpha)
    VaR = -(mu + sigma * q)
    if dist isa Normal
        ETL = -mu + sigma * pdf(dist, q) / alpha  
    elseif dist isa TDist
        v = dist.ν
        t_pdf = pdf(dist, q) 
        ETL = -mu + sigma * (t_pdf / alpha) * (v + q^2) / (v - 1)
    else # Numerical integration fallback
        E_X_cond, _ = quadgk(x -> x * pdf(dist, x), -Inf, q)
        ETL = -(mu + sigma * (E_X_cond / alpha))
    end
    return VaR, ETL
end


# Function to compute VaR and ETL using Historical Simulation
function VaR_ETL(returns::Vector{Union{Missing, Float64}}, alpha::Real)
    n = length(returns)
    if alpha * n < 1
        @warn "Insufficient data: alpha * n < 1. Either increase sample size or use a larger alpha."
        return NaN, NaN
    end
    sorted_returns = sort(returns)
    index = Int(floor(alpha * n))
    VaR = -sorted_returns[index]
    ETL = -mean(sorted_returns[1:index])
    return VaR, ETL
end

# Function to compute VaR using Historical Simulation
function VaR(returns::Vector{Union{Missing, Float64}}, alpha::Real)
    n = length(returns)
    if alpha * n < 1
        @warn "Insufficient data: alpha * n < 1. Either increase sample size or use a larger alpha."
        return NaN, NaN
    end
    sorted_returns = sort(returns)
    index = Int(floor(alpha * n))
    VaR = -sorted_returns[index]
    return VaR
end

# Function to compute ETL using Historical Simulation
function ETL(returns::Vector{Union{Missing, Float64}}, alpha::Real)
    n = length(returns)
    if alpha * n < 1
        @warn "Insufficient data: alpha * n < 1. Either increase sample size or use a larger alpha."
        return NaN, NaN
    end
    sorted_returns = sort(returns)
    index = Int(floor(alpha * n))
    ETL = -mean(sorted_returns[1:index])
    return ETL
end


"""
    hurstindex(R::AbstractArray{<:Number})

Measures whether returns are random, peristent, or mean reverting.
   * 0 to 0.5: mean reverting    
   * 0.5: random
   * 0.5 to 1: persistent
```math
HurstIndex = \\frac{log(\\frac{[max(r) - min(r)]}{\\sigma})}{log(n)}
```
"""
function hurst_exponent(R::Vector{Union{Missing, Float64}}; min_window::Int=10, max_window::Int=100, window_step::Int=5)
    n = length(R)
    log_rs = Float64[]
    log_window = Float64[]
    
    for window in min_window:window_step:min(n, max_window)
        num_segments = div(n, window)
        rs_values = Float64[]
        
        for i in 1:num_segments
            segment = R[(i-1)*window+1 : i*window]
            mean_adj = segment .- mean(segment)
            cumulative_dev = cumsum(mean_adj)
            r = maximum(cumulative_dev) - minimum(cumulative_dev)
            s = std(segment)
            
            push!(rs_values, r / s)
        end
        
        push!(log_rs, mean(log.(rs_values)))
        push!(log_window, log(window))
    end
    
    # Estimate slope (Hurst exponent) using linear regression
    H = cov(log_window, log_rs) / var(log_window)
    return H
end


"""
    trackingerror(Ra::AbstractArray{<:Number},Rb::AbstractArray{<:Number},scale::Number=1)

Measures how well a return tracks its benchmark.
```math
TrackingError(r_a,r_b) = \\sqrt{\\sum_{t=1}^n\\frac{(r_{a,t} -r_{b,t})^2}{n}}
```
"""
trackingerror(Ra::Vector{Union{Missing, Float64}},Rb::Vector{Union{Missing, Float64}}) = sqrt( sum( ((Ra.-Rb).^2)./(length(Ra)) ) )

