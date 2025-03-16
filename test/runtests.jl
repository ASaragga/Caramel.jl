using Caramel
using Test
using Dates 

@testset "Symbols.jl File" begin
    @test SP500[5]=="MMM"
end

@testset "Dates Package Functionality" begin
    # Test basic date construction
    d = Date(2024, 3, 12)
    @test d == Date("2024-03-12", dateformat"y-m-d")

    # Test date arithmetic
    @test d + Day(1) == Date(2024, 3, 13)
    @test d - Month(1) == Date(2024, 2, 12)

    # Test time construction and arithmetic
    t = Time(14, 30, 0)
    @test t + Minute(45) == Time(15, 15, 0)

    # Test DateTime parsing and formatting
    dt = DateTime("2024-03-12T14:30:00")
    @test Dates.format(dt, "yyyy-mm-dd HH:MM:SS") == "2024-03-12 14:30:00"

    # Test that invalid dates throw an error
    @test_throws ArgumentError Date(2024, 2, 30)  # Invalid date (Feb 30 doesn't exist)
end
