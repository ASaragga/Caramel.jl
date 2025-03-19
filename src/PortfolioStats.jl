# Measures of total and loss risk. 
# Measures of market performance 

################################
# Drawdowns:
"""
    drawdown(x::AbstractArray{<:Number})

Is the drawdown of each return from the last peak. Is the same length as the return series provided.
"""
function drawdown(R::AbstractArray{<:Number})
    res = Array{Float64}(undef,size(R,1))
    peak = 0 
    for i in eachindex(R)
        val = 1
        borne = peak +1
        for j in borne:i
            val = val*(1 + R[j])
        end
        if (val >1)
            peak = i 
            res[i] = 0
        else
            res[i] = val-1
        end
    end
    return res*-1
end
"""
    drawdown(x::LogReturn)

Is the drawdown of each return from the last peak.
"""
function drawdown(AR::LogReturn)
    R = AR.values
    res = Array{Float64}(undef,size(R,1))
    peak = 0 
    for i in eachindex(R)
        val = 1
        borne = peak +1
        for j in borne:i
            val = val*(1 + R[j])
        end
        if (val >1)
            peak = i 
            res[i] = 0
        else
            res[i] = val-1
        end
    end
    return res*-1
end

"""
    drawdown(x::SimpleReturn)

Is the drawdown of each return from the last peak.
"""
function drawdown(AR::SimpleReturn)
    R = AR.values
    res = Array{Float64}(undef,size(R,1))
    peak = 0 
    for i in eachindex(R)
        val = 1
        borne = peak +1
        for j in borne:i
            val = val*(1 + R[j])
        end
        if (val >1)
            peak = i 
            res[i] = 0
        else
            res[i] = val-1
        end
    end
    return res*-1
end


"""
    maxdrawdown(x::AbstractArray{<:Number})

Calculates the maximum drawdow for a return series.
"""
maxdrawdown(x::AbstractArray{<:Number}) = maximum(drawdown(x))
"""
    maxdrawdown(x::LogReturn)

Calculates the maximum drawdow for a return series.
"""
maxdrawdown(x::LogReturn) = maximum(drawdown(x))

"""
    maxdrawdown(x::SimpleReturn)

Calculates the maximum drawdow for a return series.
"""
maxdrawdown(x::SimpleReturn) = maximum(drawdown(x))


"""
    drawdownpeak(x::AbstractArray{<:Number})

Calculates the cumulative drawdown since the last peak for each return in the time series.
"""
function drawdownpeak(R::AbstractArray{<:Number})
    drawdownpeak = fill(NaN, size(R,1))
    peak = 0
    for i in 1:size(R,1) 
        val = 1
        borne = peak + 1
        for j in (borne:i) 
            val = val * (1 + R[j]/100)
        end
        if (val > 1) 
            peak = i
            drawdownpeak[i] = 0
        else 
        drawdownpeak[i] = (val - 1) * 100
        end
    end                
    result = drawdownpeak            
    return result.*-1
end
"""
    drawdownpeak(x::LogReturn)

Calculates the cumulative drawdown since the last peak for each return in the time series.
"""
function drawdownpeak(AR::LogReturn)
    R = AR.values
    drawdownpeak = fill(NaN, size(R,1))
    peak = 0
    for i in 1:size(R,1) 
        val = 1
        borne = peak + 1
        for j in (borne:i) 
            val = val * (1 + R[j]/100)
        end
        if (val > 1) 
            peak = i
            drawdownpeak[i] = 0
        else 
        drawdownpeak[i] = (val - 1) * 100
        end
    end                
    result = drawdownpeak            
    return result.*-1
end
"""
    drawdownpeak(x::SimpleReturn)

Calculates the cumulative drawdown since the last peak for each return in the time series.
"""
function drawdownpeak(AR::SimpleReturn)
    R = AR.values
    drawdownpeak = fill(NaN, size(R,1))
    peak = 0
    for i in 1:size(R,1) 
        val = 1
        borne = peak + 1
        for j in (borne:i) 
            val = val * (1 + R[j]/100)
        end
        if (val > 1) 
            peak = i
            drawdownpeak[i] = 0
        else 
        drawdownpeak[i] = (val - 1) * 100
        end
    end                
    result = drawdownpeak            
    return result.*-1
end

"""
    avgdrawdown(x::AbstractArray{<:Number})

Returns the average drowdown for a return series.
"""
avgdrawdown(x::AbstractArray{<:Number}) = mean_arith(drawdown_table(x)[:,2])
"""
    avgdrawdown(x::LogReturn)

Returns the average drowdown for a return series.
"""
avgdrawdown(x::LogReturn) = mean_arith(drawdown_table(x)[:,2])
"""
    avgdrawdown(x::SimpleReturn)

Returns the average drowdown for a return series.
"""
avgdrawdown(x::SimpleReturn) = mean_arith(drawdown_table(x)[:,2])

"""
    drawdown_table(x::AbstractArray{<:Number},dates::AbstractArray{<:TimeType})

Returns a matrix of drawdowns sorted by depth. The second column returns the depth of the drawdown.
The 3rd, 4th, and 5th columns return the start, deepest point, and final date of the drawdown.
The last column returns the length of the drawdown from the start to the end.
"""
function drawdown_table(x::AbstractArray{<:Number},dates::AbstractArray{<:TimeType}) 
    ds = drawdown(x)::Vector{<:Number}
    dd_num = Int[]
    dd_start=Int[]
    dd_end = Int[]
    
    old_val = 0.0
    count = 0
    for i in eachindex(ds)
        if (ds[i]>0) & (isequal(old_val, 0))
            count+=1
            push!(dd_num,count)
            push!(dd_start,i)
            old_val = ds[i]
        elseif isequal(ds[i],0) & (old_val>0)
            push!(dd_end,i) # i-1
            old_val=ds[i]
        elseif isequal(length(ds),i) & (ds[i]>0)
            push!(dd_end,i)
        elseif (ds[i]>0) & (old_val>0)
            old_val=ds[i]
        else
            old_val=ds[i]
        end
    end
    depth = Float64[]
    through = Date[]
    for i in eachindex(dd_start)
        push!(depth,maximum(ds[dd_start[i]:dd_end[i]]))
        push!(through,dates[isequal.(ds,depth[end])][1])
    end
    m = hcat(dd_num,depth,Date.(dates[dd_start]),through,Date.(dates[dd_end]),Day.(dd_end .+1 .- dd_start))
    return m[sortperm(-m[:,2]),:]
end
"""
    drawdown_table(x::LogReturn)

Returns a matrix of drawdowns sorted by depth. The second column returns the depth of the drawdown.
The 3rd, 4th, and 5th columns return the start, deepest point, and final date of the drawdown.
The last column returns the length of the drawdown from the start to the end.
"""
function drawdown_table(x::LogReturn) 
    ds = drawdown(x)::Vector{<:Number}
    dd_num = Int[]
    dd_start=Int[]
    dd_end = Int[]
    
    old_val = 0.0
    count = 0
    for i in eachindex(ds)
        if (ds[i]>0) & (isequal(old_val, 0))
            count+=1
            push!(dd_num,count)
            push!(dd_start,i)
            old_val = ds[i]
        elseif isequal(ds[i],0) & (old_val>0)
            push!(dd_end,i) # i-1
            old_val=ds[i]
        elseif isequal(length(ds),i) & (ds[i]>0)
            push!(dd_end,i)
        elseif (ds[i]>0) & (old_val>0)
            old_val=ds[i]
        else
            old_val=ds[i]
        end
    end
    depth = Float64[]
    through = Date[]
    for i in eachindex(dd_start)
        push!(depth,maximum(ds[dd_start[i]:dd_end[i]]))
        push!(through, timestamp(x)[isequal.(ds,depth[end])][1])
    end
    m = hcat(dd_num,depth,Date.(timestamp(x)[dd_start]),through,Date.(timestamp(x)[dd_end]),Day.(dd_end .+1 .- dd_start))
    return m[sortperm(-m[:,2]),:]
end

"""
    drawdown_table(x::SimpleReturn)

Returns a matrix of drawdowns sorted by depth. The second column returns the depth of the drawdown.
The 3rd, 4th, and 5th columns return the start, deepest point, and final date of the drawdown.
The last column returns the length of the drawdown from the start to the end.
"""
function drawdown_table(x::SimpleReturn) 
    ds = drawdown(x)::Vector{<:Number}
    dd_num = Int[]
    dd_start=Int[]
    dd_end = Int[]
    
    old_val = 0.0
    count = 0
    for i in eachindex(ds)
        if (ds[i]>0) & (isequal(old_val, 0))
            count+=1
            push!(dd_num,count)
            push!(dd_start,i)
            old_val = ds[i]
        elseif isequal(ds[i],0) & (old_val>0)
            push!(dd_end,i) # i-1
            old_val=ds[i]
        elseif isequal(length(ds),i) & (ds[i]>0)
            push!(dd_end,i)
        elseif (ds[i]>0) & (old_val>0)
            old_val=ds[i]
        else
            old_val=ds[i]
        end
    end
    depth = Float64[]
    through = Date[]
    for i in eachindex(dd_start)
        push!(depth,maximum(ds[dd_start[i]:dd_end[i]]))
        push!(through, timestamp(x)[isequal.(ds,depth[end])][1])
    end
    m = hcat(dd_num,depth,Date.(timestamp(x)[dd_start]),through,Date.(timestamp(x)[dd_end]),Day.(dd_end .+1 .- dd_start))
    return m[sortperm(-m[:,2]),:]
end

# End Drawdowns





################################
# Portfolio Statistics:

"""
    annualize(R::Number,scale::Float64=252)

Annualizes the return using the scaling factor.
"""
function annualize(R::Number,scale::Float64=252.0)
        return ((1+R)^(scale))-1
end
"""
    annualize(R::SimpleReturn)

Annualizes the return.
"""
function annualize(R::SimpleReturn)
        n_values = ((1 .+ R.values).^(R.scale)).-1
        return SimpleReturn(n_values,R.timestamp,R.freq,1.,string(R.id," Annual"),R.exchange)
end
"""
    annualize(R::LogReturn)

Annualizes the return.
"""
function annualize(R::LogReturn)
        n_values = R.values .* R.scale
        return LogReturn(n_values,R.timestamp,R.freq,1.,string(R.id," Annual"),R.exchange)
end

"""
    activepremium(Ra::Number, Rb::Number; scalea=1, scaleb=1)

Is defined as the annualized return minus the annualized benchmark return.
"""
function activepremium(Ra::Number, Rb::Number; scalea=1, scaleb=1)
    annualize(Ra, scalea) - annualize(Rb, scaleb)
end
"""
    activepremium(Ra::SimpleReturn, Rb::SimpleReturn)

Is defined as the annualized return minus the annualized benchmark return.
"""
function activepremium(Ra::SimpleReturn, Rb::SimpleReturn)
    annualize(mean_geo(Ra), Ra.scale) - annualize(mean_geo(Rb), Rb.scale)
end

"""
    activepremium(Ra::LogReturn, Rb::LogReturn)

Is defined as the annualized return minus the annualized benchmark return.
"""
function activepremium(Ra::LogReturn, Rb::LogReturn)
    annualize(mean_arith(Ra), Ra.scale) - annualize(mean_arith(Rb), Rb.scale)
end


"""
    sharperatio(R::Number,σ::Number,Rf::Number=0.;scale=1)

Calculates the Sharpe Ratio from a given return, standard deviation, and risk free rate.

```math
SR=\\frac{r_a - r_f}{\\sigma_a}
```
"""
sharperatio(R::Number,σ::Number,Rf::Number=0.;scale=1) = (R-Rf)*sqrt(scale)/σ

"""
    sharperatio(R::AbstractArray{<:Number},Rf::Number=0.;scale)

Calculates the Sharpe Ratio from a given return series and a risk free rate.
"""
function sharperatio(R::AbstractArray{<:Number},Rf::Number=0.;scale=1)
    σ = stdvs(R)*sqrt(scale)
    μ = mean_arith(R)*(scale)
    return sharperatio(μ,σ,Rf)
end
"""
    sharperatio(R::SimpleReturn,Rf::Number=0.)

Calculates the annualized Sharpe Ratio.
"""
function sharperatio(R::SimpleReturn,Rf::Number=0.)
    σ = stdvs(R)*sqrt(R.scale)
    μ = (mean_geo(R)+1)^(R.scale).-1
    return sharperatio(μ,σ,Rf)
end
"""
    sharperatio(R::LogReturn,Rf::Number=0.)

Calculates the annualized Sharpe Ratio.
"""
function sharperatio(R::LogReturn,Rf::Number=0.)
    σ = stdvs(R)*sqrt(R.scale)
    μ = mean_arith(R) * (R.scale)
    return sharperatio(μ,σ,Rf)
end

"""
    adjustedsharpe(R::Number,σ::Number,S::Number,K::Number,Rf::Number=0.)

Calculates the Adjusted Sharpe Ratio from Pezier and White (2006) for a preestimated return, standard deviation, skewness, and kurtosis. It adjusts for skewness and kurtosis.
```math
AdjSR=SR * [1+\\frac{2}{6}*SR - (\\frac{K-3}{24})*SR^2]
```
"""
function adjustedsharpe(R::Number,σ::Number,S::Number,K::Number,Rf::Number=0.;scale=1)
    SR = sharperatio(R,σ,Rf) *sqrt(scale)
    return SR * [1+(S/6)*SR - ((K-3)/24)*(SR^2)]
end


"""
    AdjustedSharp(R::AbstractArray{<:Number},Rf::Number=0.;method::AbstractString="population")

Calculates the Adjusted Sharpe Ratio from Pezier and White (2006) for a return series.  

`method`: specifies the method to be used in the estimation of the Skewness and Kurtosis. Can be one of sample, population, or fisher. Defaults to "population"
"""
function adjustedsharpe(R::AbstractArray{<:Number},Rf::Number=0.;method::AbstractString="simple",scale=1)
    μ = mean_arith(R) * scale
    σ = stdvs(R)*sqrt(scale)
    SR = sharperatio(μ,σ,Rf)
    S = skew(R,method)
    K = kurt(R,method)
    return SR * (1+(S/6)*SR - ((K-3)/24)*(SR^2))
end
"""
    AdjustedSharpe(R::SimpleReturn,Rf::Number=0.;method::AbstractString="simple")

Calculates the annualized Adjusted Sharpe Ratio from Pezier and White (2006) for a SimpleReturn.  

`method`: specifies the method to be used in the estimation of the Skewness and Kurtosis. Can be one of sample, population, or fisher. Defaults to "population"
"""
function adjustedsharpe(R::SimpleReturn,Rf::Number=0.;method::AbstractString="simple")
    μ = mean_arith(R) * R.scale
    σ = stdvs(R)*sqrt(R.scale)
    SR = sharperatio(μ,σ,Rf)
    S = skew(R,method)
    K = kurt(R,method)
    return SR * (1+(S/6)*SR - ((K-3)/24)*(SR^2))
end 
"""
    AdjustedSharpe(R::LogReturn,Rf::Number=0.;method::AbstractString="simple")

Calculates the annualized Adjusted Sharpe Ratio from Pezier and White (2006) for a SimpleReturn.  

`method`: specifies the method to be used in the estimation of the Skewness and Kurtosis. Can be one of sample, population, or fisher. Defaults to "population"
"""
function adjustedsharpe(R::LogReturn,Rf::Number=0.;method::AbstractString="simple")
    μ = mean_arith(R) * R.scale
    σ = stdvs(R)*sqrt(R.scale)
    SR = sharperatio(μ,σ,Rf)
    S = skew(R,method)
    K = kurt(R,method)
    return SR * (1+(S/6)*SR - ((K-3)/24)*(SR^2))
end 



"""
    bernardoledoitratio(R::AbstractVector{<:Number})

Calculates the Bernardo Ledoit ratio for a return series.

```math
Bernardo Ledoit Ratio = \\frac{\\frac{1}{n}\\sum_{t=1}^{n}max(r_t,0)}{\\frac{1}{n}\\sum_{t=1}^{n}max(-r_t,0)}
```
"""
function bernardoledoitratio(R::AbstractVector{<:Number})
    n = length(R)
    return ((1/n) * sum(max.(R,0)))/((1/n)*sum(max.(R*(-1),0)))
end
"""
    bernardoledoitratio(R::AssetReturn)

Calculates the Bernardo Ledoit ratio for a AssetReturn.
"""
function bernardoledoitratio(R::SimpleReturn)
    n = length(R.values)
    return ((1/n) * sum(max.(R.values,0)))/((1/n)*sum(max.(R.values*(-1),0)))
end
"""
    bernardoledoitratio(R::AssetReturn)

Calculates the Bernardo Ledoit ratio for a AssetReturn.
"""
function bernardoledoitratio(R::LogReturn)
    n = length(R.values)
    return ((1/n) * sum(max.(R.values,0)))/((1/n)*sum(max.(R.values*(-1),0)))
end



"""
    burkeratio(Ra::AbstractArray{<:Number}, Drawdowns::AbstractArray{<:Number};Rf::Number=0.,scale=1)

Calculates the Burke Ratio from a return series, a risk free rate, and drawdowns.

```math
BurkeRatio = \\frac{r_a-r_f}{\\sqrt{\\sum_{t=1}^{d}D_t^2}}
```
"""
function burkeratio(Ra::Number, Drawdowns::AbstractArray{<:Number};Rf::Number=0.,scale=1)
    μ = (Ra-Rf+1)^(scale)-1
    return μ/ sqrt(sum(Drawdowns^2))
end
"""
    burkeratio(R::AbstractArray{<:Number}; Rf::Float64 = 0., modified::Bool = false, scale::Number=1)

Calculates the Burke Ratio from a return series and a risk free rate.  

# Arguments  
   * Ra is a vector of returns.  
   * Rf is a risk free rate
   * modified adjusted for the number of drawdowns (default is false)
   * scale to annualize  (default to 1)
"""
function burkeratio(R::AbstractArray{<:Number}; Rf::Float64 = 0., modified::Bool = false, scale::Number=1)
    dd = []
    n = size(R,1)
    number_drawdown = 0
    in_drawdown = false
    peak = 1 
    for i in 2:size(R,1) 
        if (R[i] < 0) 
            if (!in_drawdown)
            peak = i - 1
            number_drawdown = number_drawdown + 1
            in_drawdown = true
            end
        else 
            if (in_drawdown) 
            temp = 1
            boundary1 = peak + 1
            boundary2 = i - 1
            for j in (boundary1:boundary2) 
                temp *= (1 + R[j] * 0.01)
            end
            push!(dd, (temp - 1) * 100)
            in_drawdown = false
            end
        end
    end
    if (in_drawdown) 
        temp = 1
        boundary1 = peak + 1
        boundary2 = i
        for j in (boundary1:boundary2) 
            temp *= (1 + R[j] * 0.01)
        end
        push!(dd, (temp - 1) * 100)
        in_drawdown = false
    end
    Rp = sum(R)*(scale/size(R,1))
    result = (Rp - Rf)/sqrt(sum(dd.^2))
    if (modified) 
        result = result * sqrt(n)
    end
    return(result)
end
"""
    burkeratio(AR::SimpleReturn; Rf::Float64 = 0., modified::Bool = false)

Calculates the Burke Ratio from a return series and a risk free rate.

# Arguments  
   * Ra is a vector of returns.  
   * Rf is the risk free rate.
   * modified adjusted for the number of drawdowns (default is false)
"""
function burkeratio(AR::SimpleReturn; Rf::Float64 = 0., modified::Bool = false)
    R = AR.values
    dd = Float64[]
    n = size(R,1)
    number_drawdown = 0
    in_drawdown = false
    peak = 1 
    for i in 2:size(R,1) 
        if (R[i] < 0) 
            if (!in_drawdown)
            peak = i - 1
            number_drawdown = number_drawdown + 1
            in_drawdown = true
            end
        else 
            if (in_drawdown) 
            temp = 1
            boundary1 = peak + 1
            boundary2 = i - 1
            for j in (boundary1:boundary2) 
                temp *= (1 + R[j] * 0.01)
            end
            push!(dd, (temp - 1) * 100)
            in_drawdown = false
            end
        end
    end
    if (in_drawdown) 
        temp = 1
        boundary1 = peak + 1
        boundary2 = i
        for j in (boundary1:boundary2) 
            temp *= (1 + R[j] * 0.01)
        end
        push!(dd, (temp - 1) * 100)
        in_drawdown = false
    end
    Rp = (prod(1 .+ R))^(AR.scale/size(R,1)) - 1
    result = (Rp - Rf)/sqrt(sum(dd.^2))
    if (modified) 
        result = result * sqrt(n)
    end
    return(result)
end
"""
    burkeratio(AR::LogReturn; Rf::Float64 = 0., modified::Bool = false)

Calculates the Burke Ratio from a return series and a risk free rate.

# Arguments  
   * Ra is a vector of returns.  
   * Rf is the risk free rate.
   * modified adjusted for the number of drawdowns (default is false)
"""
function burkeratio(AR::LogReturn; Rf::Float64 = 0., modified::Bool = false)
    R = AR.values
    dd = Float64[]
    n = size(R,1)
    number_drawdown = 0
    in_drawdown = false
    peak = 1 
    for i in 2:size(R,1) 
        if (R[i] < 0) 
            if (!in_drawdown)
            peak = i - 1
            number_drawdown = number_drawdown + 1
            in_drawdown = true
            end
        else 
            if (in_drawdown) 
            temp = 1
            boundary1 = peak + 1
            boundary2 = i - 1
            for j in (boundary1:boundary2) 
                temp *= (1 + R[j] * 0.01)
            end
            push!(dd, (temp - 1) * 100)
            in_drawdown = false
            end
        end
    end
    if (in_drawdown) 
        temp = 1
        boundary1 = peak + 1
        boundary2 = i
        for j in (boundary1:boundary2) 
            temp *= (1 + R[j] * 0.01)
        end
        push!(dd, (temp - 1) * 100)
        in_drawdown = false
    end
    Rp = sum(R)*(AR.scale/size(R,1)) 
    result = (Rp - Rf)/sqrt(sum(dd.^2))
    if (modified) 
        result = result * sqrt(n)
    end
    return(result)
end

"""
    calmarratio(R::AbstractArray{<:Number},scale::Float64=1.)

Risk return metric. Gives the annualized return divided by the maximum drawdown.  
`scale` is the scaling factor used to annualize returns (defaults tol 1.)

```math
CalmarRatio = \\frac{r_a}{maxDD}
```
"""
calmarratio(R::AbstractArray{<:Number},scale::Float64=1.) = (annualize(mean_arith(R),scale))/maxdrawdown(R)
"""
    calmarratio(R::SimpleReturn)

Risk return metric. Gives the annualized return divided by the maximum drawdown.
"""
calmarratio(R::SimpleReturn) = (annualize(mean_geo(R),R.scale))/maxdrawdown(R)

"""
    calmarratio(R::LogReturn)

Risk return metric. Gives the annualized return divided by the maximum drawdown.
"""
calmarratio(R::LogReturn) = (annualize(mean_arith(R),R.scale))/maxdrawdown(R)


"""
    downsidedeviation(R::AbstractArray{<:Number},MAR::Number = 0)

Calculates the downside deviation of a return series.
MAR = Minimum Acceptable Returns

```math
DownsideDeviation = \\sqrt{\\sum_{t=1}^n{\\frac{min[(r_t-MAR),0]^2}{n}}}
```
"""
function downsidedeviation(R::AbstractArray{<:Number},MAR::Number = 0)
    sqrt( sum( (min.(R .- MAR,0).^2)./length(R)))
end
"""
    downsidedeviation(R::SimpleReturn,MAR::Number = 0)

Calculates the downside deviation of a return series.
MAR = Minimum Acceptable Returns
"""
function downsidedeviation(R::SimpleReturn,MAR::Number = 0)
    sqrt( sum( (min.(R.values .- MAR,0).^2)./length(R.values)))
end
"""
    downsidedeviation(R::LogReturn,MAR::Number = 0)

Calculates the downside deviation of a return series.
MAR = Minimum Acceptable Returns
"""
function downsidedeviation(R::LogReturn,MAR::Number = 0)
    sqrt( sum( (min.(R.values .- MAR,0).^2)./length(R.values)))
end


"""
    DonwsidePotential(R::AbstractArray{<:Number}, MAR::Number=0)

Calculates the downside potential of a return series.
MAR = Minimum Acceptable Returns

```math
downsidepotential= \\sum_{t=1}^n{\\frac{min[(r_t-MAR),0]}{n}}
```
"""
function downsidepotential(R::AbstractArray{<:Number}, MAR::Number=0)
    return sum( (min.(R .- MAR,0))./length(R))
end

"""
    DonwsidePotential(R::SimpleReturn, MAR::Number=0)

Cals culates the downside potential of a return series.
MAR = Minimum Acceptable Returns
"""
function downsidepotential(R::SimpleReturn, MAR::Number=0)
    return sum( (min.(R.values .- MAR,0))./length(R.values))
end

"""
    DonwsidePotential(R::LogReturn, MAR::Number=0)

Cals culates the downside potential of a return series.
MAR = Minimum Acceptable Returns
"""
function downsidepotential(R::LogReturn, MAR::Number=0)
    return sum( (min.(R.values .- MAR,0))./length(R.values))
end

"""
    semideviation((R::AbstractArray{<:Number})

Calculates the semi deviation of a return series. This is equal to the downside deviation where the MAR is set to the arithmetic mean of the return series.

```math
SemiDeviation = \\sqrt{\\sum_{t=1}^n{\\frac{min[(r_t-\\overline{r}),0]^2}{n}}}
```

"""
semideviation(R::AbstractArray{<:Number}) = downsidedeviation(R,mean_arith(R))
"""
    semideviation(R::SimpleReturn)

Calculates the semi deviation of a Simple Return.
"""
semideviation(R::SimpleReturn) = downsidedeviation(R, mean_arith(R))
"""
    semideviation(R::LogReturn)

Calculates the semi deviation of a Log Return.
"""
semideviation(R::LogReturn) = downsidedeviation(R, mean_arith(R))


"""
    semivariance(R::AbstractArray{<:Number})

Calculates the semi variance of a return series. This is equal to the square of the semi deviation.

```math
SemiVariance = SemiDeviation^2  = \\sum_{t=1}^n{\\frac{min[(r_t-\\overline{r}),0]^2}{n}}
```    
"""
semivariance(R::AbstractArray{<:Number}) = downsidedeviation(R, mean_arith(R))^2
"""
    semivariance(R::SimpleReturn)

Calculates the semi variance of a SimpleReturn.
"""
semivariance(R::SimpleReturn) = downsidedeviation(R, mean_arith(R))^2
"""
    semivariance(R::LogReturn)

Calculates the semi variance of a LogReturn.
"""
semivariance(R::LogReturn) = downsidedeviation(R, mean_arith(R))^2

function VaR(sigma::Real, alpha::Real, dist::Distribution, mu::Real=0)
    q = quantile(dist, alpha)
    VaR = -(mu + sigma * q)
    return VaR
end

function VaR(returns::Vector{<:Real}, alpha::Real, dist::Distribution, mu::Real=0)
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
        v = params(dist)[1]
        t_pdf = pdf(dist, q) 
        ETL = -mu + sigma * (t_pdf / alpha) * (v + q^2) / (v - 1)
    else # Numerical integration fallback
        E_X_cond, _ = quadgk(x -> x * pdf(dist, x), -Inf, q)
        ETL = -(mu + sigma * (E_X_cond / alpha))
    end
    return ETL
end

function ETL(returns::Vector{<:Real}, alpha::Real, dist::Distribution, mu::Real=0)
    sigma = std(returns)
    q = quantile(dist, alpha)
    if dist isa Normal
        ETL = -mu + sigma * pdf(dist, q) / alpha  
    elseif dist isa TDist
        v = params(dist)[1]
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
        v = params(dist)[1]
        t_pdf = pdf(dist, q) 
        ETL = -mu + sigma * (t_pdf / alpha) * (v + q^2) / (v - 1)
    else # Numerical integration fallback
        E_X_cond, _ = quadgk(x -> x * pdf(dist, x), -Inf, q)
        ETL = -(mu + sigma * (E_X_cond / alpha))
    end
    return VaR, ETL
end

function VaR_ETL(returns::Vector{<:Real}, alpha::Real, dist::Distribution, mu::Real=0)
    sigma = std(returns)
    q = quantile(dist, alpha)
    VaR = -(mu + sigma * q)
    if dist isa Normal
        ETL = -mu + sigma * pdf(dist, q) / alpha  
    elseif dist isa TDist
        v = params(dist)[1]
        t_pdf = pdf(dist, q) 
        ETL = -mu + sigma * (t_pdf / alpha) * (v + q^2) / (v - 1)
    else # Numerical integration fallback
        E_X_cond, _ = quadgk(x -> x * pdf(dist, x), -Inf, q)
        ETL = -(mu + sigma * (E_X_cond / alpha))
    end
    return VaR, ETL
end


# Function to compute VaR and ETL using Historical Simulation
function VaR_ETL(returns::Vector{<:Real}, alpha::Real)
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
function VaR(returns::Vector{<:Real}, alpha::Real)
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
function ETL(returns::Vector{<:Real}, alpha::Real)
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
hurstindex(R::AbstractArray{<:Number}) = log(  (maximum(R) - minimum(R))/stdvs(R)   )/log(length(R))
"""
    hurstindex(R::SimpleReturn)

Measures whether returns are random, peristent, or mean reverting.

"""
hurstindex(R::SimpleReturn) = log(  (maximum(R.values) - minimum(R.values))/stdvs(R)   )/log(length(R.values))

"""
    hurstindex(R::LogReturn)

Measures whether returns are random, peristent, or mean reverting.

"""
hurstindex(R::LogReturn) = log(  (maximum(R.values) - minimum(R.values))/stdvs(R)   )/log(length(R.values))



"""
    kappa(R::AbstractArray{<:Number},MAR::Number=0.,k::Number=2)

If k=1 this returns the Sharpe-Omega Ratio.
If k=2 this returns the Sortino Ratio

```math
Kappa = \\frac{r-MAR}{\\sqrt[k]{\\frac{1}{n}*\\sum_{t=1}^nmax(MAR - r_t,0)^k}}
```
"""
kappa(R::AbstractArray{<:Number},MAR::Number=0.;k::Number=2) = (mean_arith(R) - MAR) / ( (1/length(R)) *sum((max.(MAR .- R,0)).^k) )^(1/k)
"""
    kappa(R::AssetReturn,MAR::Number=0.;k::Number=2)

If k=1 this returns the Sharpe-Omega Ratio.
If k=2 this returns the Sortino Ratio
"""
kappa(R::SimpleReturn,MAR::Number=0.;k::Number=2) = (mean_arith(R) - MAR) / ( (1/length(R.values)) *sum((max.(MAR .- R.values,0)).^k) )^(1/k)
kappa(R::LogReturn,MAR::Number=0.;k::Number=2) = (mean_arith(R) - MAR) / ( (1/length(R.values)) *sum((max.(MAR .- R.values,0)).^k) )^(1/k)


"""
    painindex(R::AbstractArray{<:Number})

Mean value of drawdowns over entire period.

```math
PainIndex = \\sum_{t=1}^n \\frac{|D_t|}{n}\\text{ where }D_t\\text{ is the drawdown at time t since the last peak}
```

"""
painindex(R::AbstractArray{<:Number}) = sum( abs.(drawdownpeak(R))./length(R) )
"""
    painindex(R::SimpleReturn)

Calculates the Pain Index.
"""
painindex(R::SimpleReturn) = sum( abs.(drawdownpeak(R.values))./length(R.values) ) 
"""
    painindex(R::LogReturn)

Calculates the Pain Index.
"""
painindex(R::LogReturn) = sum( abs.(drawdownpeak(R.values))./length(R.values) ) 


μn(R,n) = mean_arith((R .- mean_arith(R)).^(n))
μn(R::SimpleReturn,n) = mean_arith((R.values .- mean_arith(R)).^(n))
μn(R::LogReturn,n) = mean_arith((R.values .- mean_arith(R)).^(n))

"""
    covariance(Ra::AbstractArray{<:Number},Rb::AbstractArray{<:Number};corrected::Bool=false)

Calculates the CoVariance of two asset returns.
```math
CoVariance(R_a,R_b) = \\sum_{i=1}^n([R_a - \\overline{R_a}] \\times [R_b - \\overline{R_b}]) \\times\\frac{1}{n}
```
If `corrected=true`
```math
CoVariance(R_a,R_b) = \\sum_{i=1}^n([R_a - \\overline{R_a}] \\times [R_b - \\overline{R_b}]) \\times\\frac{1}{n-1}
```
"""
function covariance(Ra::AbstractArray{<:Number},Rb::AbstractArray{<:Number};corrected::Bool=false)
    @assert length(Ra) == length(Rb) "Ra and Rb must be of same length"
    if corrected
        return sum((Ra .- mean_arith(Ra)).*(Rb .- mean_arith(Rb)))/(length(Ra)-1)
    else
        return mean_arith(  (Ra .- mean_arith(Ra)).*(Rb .- mean_arith(Rb)))
    end
end
"""
    covariance(Ra::LogReturn,Rb::LogReturn;corrected::Bool=false)

Calculates the Covariance of two asset returns.

"""
function covariance(Ra::LogReturn,Rb::LogReturn;corrected::Bool=false)
    @assert length(Ra.values) == length(Rb.values) "Ra and Rb must be of same length"
    if corrected
        return sum((Ra.values .- mean_arith(Ra)).*(Rb.values .- mean_arith(Rb)))/(length(Ra.values)-1)
    else
        return mean_arith(  (Ra.values .- mean_arith(Ra)).*(Rb.values .- mean_arith(Rb)))
    end
end
"""
    covariance(Ra::SimpleReturn,Rb::SimpleReturn;corrected::Bool=false)

Calculates the Covariance of two asset returns.

"""
function covariance(Ra::SimpleReturn,Rb::SimpleReturn;corrected::Bool=false)
    @assert length(Ra.values) == length(Rb.values) "Ra and Rb must be of same length"
    if corrected
        return sum((Ra.values .- mean_arith(Ra)).*(Rb.values .- mean_arith(Rb)))/(length(Ra.values)-1)
    else
        return mean_arith(  (Ra.values .- mean_arith(Ra)).*(Rb.values .- mean_arith(Rb)))
    end
end


"""
    specificrisk(Ra::AbstractArray{<:Number},Rb::AbstractArray{<:Number},Rf::Number=0)

The spicific risk is calculated as the standard deviation of the residuals from a factor regression.

```math
SpecificRisk = std(\\epsilon_t) = std((r_{a,t} -r_f) - \\alpha - \\beta\\times(r_{b,t}-r_f))
```
"""
specificrisk(Ra::AbstractArray{<:Number},Rb::AbstractArray{<:Number},Rf::Number=0)= stdvs(factor_resid(Ra.-Rf,Rb.-Rf))
"""
    specificrisk(Ra::LogReturn,Rb::LogReturn,Rf::Number=0)

The specific risk is calculated as the standard deviation of the residuals from a factor regression.
"""
specificrisk(Ra::LogReturn,Rb::LogReturn,Rf::Number=0)= stdvs(factor_resid(Ra.values .-Rf,Rb.values .-Rf))


"""
    systematicrisk(Ra::AbstractArray{<:Number},Rb::AbstractArray{<:Number},Rf::Number=0)

Is the systematic risk of the return. It is calculated by multipling the factor loading from a linear factor model of the return against the benchmark return by the standard deviation of the benchmark return.
```math
SystematicRisk = \\beta_{r_a,r_b}\\times std(R_b)
```
"""
systematicrisk(Ra::AbstractArray{<:Number},Rb::AbstractArray{<:Number},Rf::Number=0) = factor_regression(Ra.-Rf,Rb.-Rf)[2]*stdvs(Rb)
"""
    systematicrisk(Ra::SimpleReturn,Rb::SimpleReturn,Rf::Number=0)

Calculated by multipling the factor loading from a linear factor model of the return against the benchmark return by the standard deviation of the benchmark return.
"""
systematicrisk(Ra::SimpleReturn,Rb::SimpleReturn,Rf::Number=0) = factor_regression(Ra.values .-Rf,Rb.values .-Rf)[2]*stdvs(Rb)
"""
    systematicrisk(Ra::LogReturn,Rb::LogReturn,Rf::Number=0)

Calculated by multipling the factor loading from a linear factor model of the return against the benchmark return by the standard deviation of the benchmark return.
"""
systematicrisk(Ra::LogReturn,Rb::LogReturn,Rf::Number=0) = factor_regression(Ra.values .-Rf,Rb.values .-Rf)[2]*stdvs(Rb)


"""
    totalrisk(Ra::AbstractArray{<:Number},Rb::AbstractArray{<:Number},Rf::Number=0)

Total risk is defined as a combination of systematic and specific risk.

```math
TotalRisk = \\sqrt{SystematicRisk^2+SpecificRisk^2}
```
"""
totalrisk(Ra::AbstractArray{<:Number},Rb::AbstractArray{<:Number},Rf::Number=0) = sqrt(systematicrisk(Ra,Rb,Rf)^2 + specificrisk(Ra,Rb,Rf)^2)

"""
    totalrisk(Ra::LogReturn,Rb::LogReturn,Rf::Number=0)

Total risk is defined as a combination of systematic and specific risk.
"""
totalrisk(Ra::LogReturn,Rb::LogReturn,Rf::Number=0) = sqrt(systematicrisk(Ra,Rb,Rf)^2 + specificrisk(Ra,Rb,Rf)^2)
"""
    totalrisk(Ra::SimpleReturn,Rb::SimpleReturn,Rf::Number=0)

Total risk is defined as a combination of systematic and specific risk.
"""
totalrisk(Ra::SimpleReturn,Rb::SimpleReturn,Rf::Number=0) = sqrt(systematicrisk(Ra,Rb,Rf)^2 + specificrisk(Ra,Rb,Rf)^2)

    
"""
    trackingerror(Ra::AbstractArray{<:Number},Rb::AbstractArray{<:Number},scale::Number=1)

Measures how well a return tracks its benchmark.
```math
TrackingError(r_a,r_b) = \\sqrt{\\sum_{t=1}^n\\frac{(r_{a,t} -r_{b,t})^2}{n}}
```
"""
trackingerror(Ra::AbstractArray{<:Number},Rb::AbstractArray{<:Number},scale::Number=1) = sqrt( sum( ((Ra.-Rb).^2)./(length(Ra)) ) )*sqrt(scale)
"""
    trackingerror(Ra::LogReturn,Rb::LogReturn)

Measures how well a return tracks its benchmark.
"""
trackingerror(Ra::LogReturn,Rb::LogReturn) = sqrt( sum( ((Ra.values.-Rb.values).^2)./(length(Ra.values))))*sqrt(Ra.scale)
"""
    trackingerror(Ra::SimpleReturn,Rb::SimpleReturn)

Measures how well a return tracks its benchmark.
"""
trackingerror(Ra::SimpleReturn,Rb::SimpleReturn) = sqrt( sum( ((Ra.values.-Rb.values).^2)./(length(Ra.values))))*sqrt(Ra.scale)


"""
    informationratio(Ra::AbstractArray{<:Number},Rb::AbstractArray{<:Number},scale::Number=1)

Calculates the Information Ratio. It is defined as the Active Premium over the Tracking Error.
The tracking error needs to be annualized therefore it is important to specify the periodecity of the data with scale.

```math
InformationRatio(Ra,Rb,scale) = \\frac{ActivePremium(r_a,r_b,scale)}{TrackingError(r_a,r_b,scale)} = \\frac{(1+\\overline{r_a})^{scale}- (1+\\overline{r_b})^{scale}}{\\sqrt{\\sum_{t=1}^n\\frac{(r_{a,t} -r_{b,t})^2}{n\\times\\sqrt{scale}}}}
```
"""
function informationratio(Ra::AbstractArray{<:Number},Rb::AbstractArray{<:Number};scale::Number=1)
        return (activepremium(Ra,Rb,scalea=scale,scaleb=scale) /trackingerror(Ra,Rb,scale))
end
"""
    informationratio(Ra::LogReturn,Rb::LogReturn)

Calculates the Information Ratio. It is defined as the Active Premium over the Tracking Error.
"""
function informationratio(Ra::LogReturn,Rb::LogReturn)
    return (activepremium(Ra,Rb) / trackingerror(Ra,Rb))
end
"""
    informationratio(Ra::AssetReturn,Rb::AssetReturn)

Calculates the Information Ratio. It is defined as the Active Premium over the Tracking Error.
"""
function informationratio(Ra::SimpleReturn,Rb::SimpleReturn)
    return (activepremium(Ra,Rb) / trackingerror(Ra,Rb))
end
   


"""
    treynorratio(Ra::AbstractArray{<:Number},Rb::AbstractArray{<:Number},Rf::Number=0;modified::Bool=false,scale=1)

Scale argument used to annualize all numbers for daily data use 252 (default is 1), for monthly 12, etc.  

SharpeRatio that uses beta as risk rather than the assets standard deviation of returns.
The modified TreynorRatio uses the systematic risk rather than the beta.

```math
TreynorRatio = \\frac{\\frac{1}{n}\\times\\sum_{t=1}^n (r_{a,t}-r_{f,t})}{\\beta_{r_a,r_b}}
```

```math
ModifiedTreynorRatio = \\frac{\\frac{1}{n}\\times\\sum_{t=1}^n (r_{a,t}-r_{f,t})}{\\beta_{r_a,r_b}\\times std(R_b)}
```
"""
function treynorratio(Ra::AbstractArray{<:Number},Rb::AbstractArray{<:Number},Rf::Number=0;modified::Bool=false,scale=1)
    if modified
        risk = systematicrisk(Ra,Rb,Rf)*sqrt(scale)
    else
        risk = factor_regression(Ra.-Rf,Rb.-Rf)[2]
    end
    return ((mean_geo(Ra.-Rf)+1)^(scale) -1)  /risk
end
"""
    treynorratio(Ra::AssetReturn,Rb::AssetReturn,Rf::Number=0;modified::Bool=false)

Calculates the Treynor Ratio.
"""
function treynorratio(Ra::SimpleReturn,Rb::SimpleReturn,Rf::Number=0;modified::Bool=false)
    if modified
        risk = systematicrisk(Ra,Rb,Rf)*sqrt(Ra.scale)
    else
        risk = factor_regression(Ra.values .-Rf,Rb.values .-Rf)[2]
    end
    return ((mean_geo(Ra.values .-Rf)+1)^(Ra.scale) -1)  /risk
end
"""
    treynorratio(Ra::AssetReturn,Rb::AssetReturn,Rf::Number=0;modified::Bool=false)

Calculates the Treynor Ratio.
"""
function treynorratio(Ra::LogReturn,Rb::LogReturn,Rf::Number=0;modified::Bool=false)
    if modified
        risk = systematicrisk(Ra,Rb,Rf)*sqrt(Ra.scale)
    else
        risk = factor_regression(Ra.values .-Rf,Rb.values .-Rf)[2]
    end
    return ((mean_geo(Ra.values .-Rf)+1)^(Ra.scale) -1)  /risk
end

"""
    jensensalpha(Y::AbstractArray{<:Number},X::AbstractArray{<:Number}...;scale::Number=1)

Returns the annualized Jensens Alpha.

# Arguments
   * `Y` the assets return
   * `X` the benchmark return 
   * `scale` the scaling number used to annualize returns (defaults to 1)

"""
function jensensalpha(Y::AbstractArray{<:Number},X::AbstractArray{<:Number}...;scale::Number=1)
    coefs = factor_regression(Y,X...)[2:end]
    y_bar = annualize(mean_geo(Y),scale)
    x_bars = annualize.(mean_geo.(X),scale)
    α = y_bar - sum( coefs.*x_bars)
    return α
end
"""
    jensensalpha(Y::AssetReturn,X::AssetReturn...)

Returns the annualized Jensens Alpha.
"""
function jensensalpha(Y::LogReturn,X::LogReturn...)
    coefs = factor_regression(Y,X...)[2:end]
    y_bar = annualize(mean_geo(Y),Y.scale)
    x_bars = annualize.(mean_geo.(X),Y.scale)
    α = y_bar - sum( coefs.*x_bars)
    return α
end
"""
    jensensalpha(Y::AssetReturn,X::AssetReturn...)

Returns the annualized Jensens Alpha.
"""
function jensensalpha(Y::SimpleReturn,X::SimpleReturn...)
    coefs = factor_regression(Y,X...)[2:end]
    y_bar = annualize(mean_geo(Y),Y.scale)
    x_bars = annualize.(mean_geo.(X),Y.scale)
    α = y_bar - sum( coefs.*x_bars)
    return α
end

"""
    appraisalratio(Ra::AbstractArray{<:Number},Rb::AbstractArray{<:Number},Rf::Number=0,method::AbstractString = "appraisal",scale::Number=1)

Jensen's Alpha adjusted for risk.
The `modified` version uses β as the risk measure.
The `appraisal` version uses specific risk.
The `alternative` version uses systematic risk.

```math
\\frac{\\alpha}{risk measure}
```

"""
function appraisalratio(Ra::AbstractArray{<:Number},Rb::AbstractArray{<:Number},Rf::Number=0;method::AbstractString = "appraisal",scale::Number=1)
    if isequal(method,"appraisal")
        return jensensalpha(Ra .-Rf, Rb .-Rf,scale=scale)/ (specificrisk(Ra,Rb,Rf)*sqrt(scale))
    elseif isequal(method,"modified")
        return jensensalpha(Ra .-Rf, Rb .-Rf,scale=scale)/ (factor_regression(Ra .-Rf, Rb .-Rf)[2]*sqrt(scale))
    elseif isequal(method,"alternative")
        return jensensalpha(Ra .-Rf, Rb .-Rf,scale=scale)/ (systematicrisk(Ra,Rb,Rf)*sqrt(scale)) 
    else
        throw("Method not valid choose from: appraisal, modified, alternative")
    end
end
"""
    appraisalratio(Ra::AssetReturn,Rb::AssetReturn,Rf::Number=0;method::AbstractString = "appraisal")

Jensen's Alpha adjusted for risk.
"""
function appraisalratio(Ra::LogReturn,Rb::LogReturn,Rf::Number=0;method::AbstractString = "appraisal")
    if isequal(method,"appraisal")
        return jensensalpha(Ra.values .-Rf, Rb.values .-Rf,scale=Ra.scale)/ (specificrisk(Ra,Rb,Rf)*sqrt(Ra.scale))
    elseif isequal(method,"modified")
        return jensensalpha(Ra.values .-Rf, Rb.values .-Rf,scale=Ra.scale)/ (factor_regression(Ra.values .-Rf, Rb.values .-Rf)[2])
    elseif isequal(method,"alternative")
        return jensensalpha(Ra.values .-Rf, Rb.values .-Rf,scale=Ra.scale)/ (systematicrisk(Ra,Rb,Rf)*sqrt(Ra.scale))
    else
        throw("Method not valid choose from: appraisal, modified, alternative")
    end
end

"""
    appraisalratio(Ra::AssetReturn,Rb::AssetReturn,Rf::Number=0;method::AbstractString = "appraisal")

Jensen's Alpha adjusted for risk.
"""
function appraisalratio(Ra::SimpleReturn,Rb::SimpleReturn,Rf::Number=0;method::AbstractString = "appraisal")
    if isequal(method,"appraisal")
        return jensensalpha(Ra.values .-Rf, Rb.values .-Rf,scale=Ra.scale)/ (specificrisk(Ra,Rb,Rf)*sqrt(Ra.scale))
    elseif isequal(method,"modified")
        return jensensalpha(Ra.values .-Rf, Rb.values .-Rf,scale=Ra.scale)/ (factor_regression(Ra.values .-Rf, Rb.values .-Rf)[2])
    elseif isequal(method,"alternative")
        return jensensalpha(Ra.values .-Rf, Rb.values .-Rf,scale=Ra.scale)/ (systematicrisk(Ra,Rb,Rf)*sqrt(Ra.scale))
    else
        throw("Method not valid choose from: appraisal, modified, alternative")
    end
end
