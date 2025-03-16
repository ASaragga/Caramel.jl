"""
Create a Q-Q plot for the given data against a normal distribution.

Parameters:
- data: A vector of numerical data (e.g., stock returns).
- title: Title of the plot (default: "Q-Q Plot").
- xlabel: Label for the x-axis (default: "Theoretical Quantiles (Normal)").
- ylabel: Label for the y-axis (default: "Sample Quantiles (Data)").

Returns:
- A Q-Q plot displayed using `Plots.jl`.
"""
function qqplot(data::Vector{Float64}; title::String="Q-Q Plot", xlabel::String="Theoretical Quantiles (Normal)", ylabel::String="Sample Quantiles (Data)")

sorted_data = sort(data)

    # Calculate theoretical quantiles from a normal distribution
    μ, σ = mean(data), std(data)
    n = length(data)
    theoretical_quantiles = quantile.(Normal(μ, σ), (1:n) ./ (n + 1))

    # Create Q-Q plot
    scatter(theoretical_quantiles, sorted_data, 
            label="Observed", 
            xlabel=xlabel, 
            ylabel=ylabel, 
            title=title, 
            legend=:topleft)

    # Add a reference line (y = x)
    plot!(theoretical_quantiles, theoretical_quantiles, 
          label="Reference Line", 
          linecolor=:red, 
          linestyle=:dash)

    # Display the plot
    display(plot!())
end