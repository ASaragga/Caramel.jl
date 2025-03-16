# Loads Daily FF Factors Returns from K. French Website data library at https://mba.tuck.dartmouth.edu/pages/faculty/ken.french/data_library.html

function get_ff_factors(Model::String)
    if Model == "FF3"
        tables, tablenotes, filenotes = readFamaFrench("F-F_Research_Data_Factors_daily")
        FF3 = tables[1]
        FF3.Date = Date.(string.(FF3.Date), DateFormat("yyyymmdd"))
        return FF3
    elseif Model == "FF5"
        tables, tablenotes, filenotes = readFamaFrench("F-F_Research_Data_5_Factors_2x3_daily")
        FF5 = tables[1]
        FF5.Date = Date.(string.(FF5.Date), DateFormat("yyyymmdd"))
        return FF5
    elseif Model == "MOM"
        tables, tablenotes, filenotes = readFamaFrench("F-F_Momentum_Factor_daily")
        MOM = tables[1]
        MOM.Date = Date.(string.(MOM.Date), DateFormat("yyyymmdd"))
        return MOM
    elseif Model == "STREV"
        tables, tablenotes, filenotes = readFamaFrench("F-F_ST_Reversal_Factor_daily")
        STREV = tables[1]
        STREV.Date = Date.(string.(STREV.Date), DateFormat("yyyymmdd"))
        return STREV
    elseif Model == "LTREV"
        tables, tablenotes, filenotes = readFamaFrench("F-F_LT_Reversal_Factor_daily")
        LTREV = tables[1]
        LTREV.Date = Date.(string.(LTREV.Date), DateFormat("yyyymmdd"))
    elseif Model == "IND"
        # Loads Daily 49 Industry Portfolios Returns from K. French Website
        tables, tablenotes, filenotes = readFamaFrench("49_Industry_Portfolios_daily")
        IND49 = tables[1]
        IND49.Date = Date.(string.(IND49.Date), DateFormat("yyyymmdd"))
        IND49 = dropmissing(IND49)
        return IND49
    else Model == "ALL"
        # Include all previous factors time-series in just one DataFrame
        tables, tablenotes, filenotes = readFamaFrench("F-F_Research_Data_5_Factors_2x3_daily")
        FF5 = tables[1]
        FF5.Date = Date.(string.(FF5.Date), DateFormat("yyyymmdd"))
        tables, tablenotes, filenotes = readFamaFrench("F-F_Momentum_Factor_daily")
        MOM = tables[1]
        MOM.Date = Date.(string.(MOM.Date), DateFormat("yyyymmdd"))
        tables, tablenotes, filenotes = readFamaFrench("F-F_ST_Reversal_Factor_daily")
        STREV = tables[1]
        STREV.Date = Date.(string.(STREV.Date), DateFormat("yyyymmdd"))
        tables, tablenotes, filenotes = readFamaFrench("F-F_LT_Reversal_Factor_daily")
        LTREV = tables[1]
        LTREV.Date = Date.(string.(LTREV.Date), DateFormat("yyyymmdd"))
        tables, tablenotes, filenotes = readFamaFrench("49_Industry_Portfolios_daily")
        IND49 = tables[1]
        IND49.Date = Date.(string.(IND49.Date), DateFormat("yyyymmdd"))
        FFs = [FF5, MOM, STREV, LTREV, IND49]
        FFALL = reduce((x, y) -> outerjoin(x, y, on=:Date), FFs)
        FFALL = dropmissing(FFALL)
        sort!(FFALL, :Date)
        return FFALL
    end
end
