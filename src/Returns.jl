# Measures of return: percentage change, log return

"""
    pct_change(x)

Returns the percent change of an array or matrix. Calculates simple returns from a price series
"""
function pct_change(x)
    return x[2:end]./x[1:(end-1)] .-1
end
# end pct_change
function pct_change(x::AbstractMatrix)
    return x[2:end, :] ./ x[1:(end-1), :] .- 1
end



"""
    log_diff(x)

Returns the logarithmic difference of an array or matrix. Calculates log returns from a price series
"""
function log_diff(x)
    return log.(x[2:end]) .- log.(x[1:(end-1)])
end
function log_diff(x::AbstractMatrix)
    return log.(x[2:end, :]) .- log.(x[1:(end-1), :])
end



"""
    diff(x)

Returns the difference. Calculates the price change
"""
function diff(x)
    return x[2:end] .- x[1:(end-1)]
end
function diff(x::AbstractMatrix)
    return x[2:end, :] .- x[1:(end-1), :]
end
# end simple diff