# Time aggregation: daily -> monthly, yearly

function cumret(R::LogReturn)
    return sum(R.values)
end
function cumret(R::SimpleReturn)
    return prod(1 .+ R.values)-1
end

"""
    to_monthly_return(R::LogReturn)

Generates a new LogReturn on a monthly frequency. This uses calendar time i.e. start of calendar month to end of calendar month.
"""
function to_monthly_return(R::LogReturn)
    # Get Window from aggregation method
    if R.scale%12 == 0
        nothing
    else
        @error "The frequency ($(R.freq)) does not allow the calculation of a monthly return series."
    end
    # Get the start and end dates of the windows:
    s_date = collect(firstdayofmonth(minimum(R.timestamp)):Month(1):firstdayofmonth(maximum(R.timestamp)))
    e_date = lastdayofmonth.(s_date)
    n_values = Array{Float64}(undef,size(s_date,1))
    for i in eachindex(s_date)
        n_values[i] = cumret(R.values[s_date[i].<=R.timestamp.<=e_date[i]])
    end
    return LogReturn(n_values,e_date,"1mo",12,R.id,R.exchange)
end


"""
    to_monthly_return(R::SimpleReturn)

Generates a new SimpleReturn on a monthly frequency. This uses calendar time i.e. start of calendar month to end of calendar month.
"""
function to_monthly_return(R::SimpleReturn)
    # Get Window from aggregation method
    if R.scale%12 == 0
        nothing
    else
        @error "The frequency ($(R.freq)) does not allow the calculation of a monthly return series."
    end
    # Get the start and end dates of the windows:
    s_date = collect(firstdayofmonth(minimum(R.timestamp)):Month(1):firstdayofmonth(maximum(R.timestamp)))
    e_date = lastdayofmonth.(s_date)
    n_values = Array{Float64}(undef,size(s_date,1))
    for i in eachindex(s_date)
        n_values[i] = cumret(R.values[s_date[i].<=R.timestamp.<=e_date[i]])
    end
    return SimpleReturn(n_values,e_date,"1mo",12,R.id,R.exchange)
end



"""
    to_annual_return(R::LogReturn)

Generates a new LogReturn on a annual frequency. This uses calendar time i.e. start of year to end of calendar year.
"""
function to_annual_return(R::LogReturn)
    # Get the start and end dates of the windows:
    s_date = collect(firstdayofmonth(minimum(R.timestamp)):Year(1):firstdayofmonth(maximum(R.timestamp)))
    e_date = lastdayofmonth.(s_date.+ Year(1)-Month(1)) 
    n_values = Array{Float64}(undef,size(s_date,1))
    for i in eachindex(s_date)
        n_values[i] = cumret(R.values[s_date[i].<=R.timestamp.<=e_date[i]])
    end
    return LogReturn(n_values,e_date,"1y",1,R.id,R.exchange)
end


"""
    to_annual_return(R::SimpleReturn)

Generates a new SimpleReturn on a annual frequency. This uses calendar time i.e. start of year to end of calendar year.
"""
function to_annual_return(R::SimpleReturn)
    # Get the start and end dates of the windows:
    s_date = collect(firstdayofmonth(minimum(R.timestamp)):Year(1):firstdayofmonth(maximum(R.timestamp)))
    e_date = lastdayofmonth.(s_date.+ Year(1)-Month(1)) 
    n_values = Array{Float64}(undef,size(s_date,1))
    for i in eachindex(s_date)
        n_values[i] = cumret(R.values[s_date[i].<=R.timestamp.<=e_date[i]])
    end
    return SimpleReturn(n_values,e_date,"1y",1,R.id,R.exchange)
end
