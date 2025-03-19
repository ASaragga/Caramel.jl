module Caramel
    # Dependencies:
    using LinearAlgebra
    using Random
    using Dates 
    using Tables
    using HTTP
    using JSON3
    using XLSX
    using SQLite, DuckDB
    using OrderedCollections
    using Optim
    using QuadGK

    # using Plots

    export Date, today

    # Base functions: Be careful about redefining them
    import Base: max, min
    max(a) = max(a...)
    min(a) = min(a...)
    export max, min # Only if the custom versions are safe!

    # Statistics functions
    import Statistics: mean, median, var, std, cov, cor
    export mean, median, var, std, cov, cor 

    import StatsBase: mad, quantile, quantilerank, describe
    export mad, quantile, quantilerank, describe

    # Probability distributions
    import Distributions: Normal, TDist, pdf, cdf, logpdf, Distribution
    export Normal, TDist, pdf, cdf, logpdf, Distribution

    # CSV
    import CSV: read, write
    export read, write

    # Databases
    import DBInterface: execute, connect, close!
    const sql = DBInterface.execute   
    const db_connect = DBInterface.connect
    const db_close = DBInterface.close!
    export sql, db_connect, db_close

    # DataFrames: Consider not exporting it
    import DataFrames: DataFrame    
    export DataFrame  # Optional—consider removing
 
 
 

    #####

    # From Structs.jl
    export _Exchange_Daily_Hours, Asset, LogReturn, SimpleReturn, AssetPrice, show, summary, values, timestamp, scale, id

    # From Stats.jl
    export mean_arith,mean_geo,varp,vars,stdvp,stdvs,skew,kurt
    export factor_regression,factor_alpha,factor_loadings,factor_resid
    export fit_mle

    #From Returns.jl
    export pct_change,log_diff,simple_diff

    #From RollingFunction.jl
    export roll_apply

    #From ReturnAggregation.jl
    export to_monthly_return, to_annual_return

    #From PortfolioStats.jl
    export drawdown,drawdownpeak,maxdrawdown,avgdrawdown,drawdown_table,annualize
    export activepremium,sharperatio,adjustedsharpe,bernardoledoitratio
    export burkeratio,calmarratio,downsidedeviation,downsidepotential,semideviation
    export semivariance, hurstindex,kappa,painindex,covariance
    export coskew,cokurt,specificrisk,systematicrisk,totalrisk,trackingerror,jensensalpha
    export informationratio,treynorratio,appraisalratio
    export VaR, ETL, VaR_ETL

    #From FamaFrench.jl
    export get_ff_factors

    #From Symmbols.jl
    export SP500, DJ30, NASDAQ, VOL, FTSE100, DAX40, CAC40, FTSEMIB, SMI, PSI, EUROSTOXX50, NIKKEI225, HKSE, ASX50
    export symbols

    #From Databases.jl
    export describe_table, db_schema, db_schemas, db_info, table_to_csv, export_table_to_xlsx, export_table_to_csv, export_table_to_parquet, sql, db_close

    #From Financials.jl
    export _Fundamental_Tables, db_create, db_insert, db_save, duckdb_to_excel, csv_to_xlsx, fundamentals, get_income_statement, get_balance_sheet, get_cash_flow, get_valuation

    #From Utilities.jl
    export valid_symbols
     
    #From General.jl
    export get_quoteSummary, get_calendar_events, get_earnings_estimates, get_insider_holders, get_insider_transactions, get_major_holders_breakdown, get_recommendation_trend, get_summary_detail, get_upgrade_downgrade_history, get_quote_type, get_entity_profile, get_key_statistics, get_target_prices, get_institutional_ownership, get_fund_ownership, get_eps_estimates, get_sec_filings, get_esg_scores, db_create_insert

    #From StockPrices.jl
    export get_prices, get_dividends, get_splits

    #From CommodityPrices.jl
    export get_commodity_prices

    include("Utilities.jl");
    include("Structs.jl");
    include("Stats.jl");
    include("Returns.jl");
    include("StockPrices.jl");
    include("OptionPrices.jl");
    include("FuturePrices.jl");
    include("CommodityPrices.jl");
    include("RollingFunction.jl");
    include("ReturnAggregation.jl");
    include("PortfolioStats.jl");
    include("Symbols.jl");
    include("Databases.jl");
    include("Financials.jl");
    include("General.jl");
    include("FamaFrench.jl")
end
