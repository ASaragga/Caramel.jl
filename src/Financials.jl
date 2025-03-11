# Download from Yahoo Finace financial statements data: income statement, cash-flow statement, balance sheet and valuation metrics

_Fundamental_Types = OrderedCollections.OrderedDict(
    "income_statement"=> [
        "Amortization",
        "AmortizationOfIntangiblesIncomeStatement",
        "AverageDilutionEarnings",
        "BasicAccountingChange",
        "BasicAverageShares",
        "BasicContinuousOperations",
        "BasicDiscontinuousOperations",
        "BasicEPS",
        "BasicEPSOtherGainsLosses",
        "BasicExtraordinary",
        "ContinuingAndDiscontinuedBasicEPS",
        "ContinuingAndDiscontinuedDilutedEPS",
        "CostOfRevenue",
        "DepletionIncomeStatement",
        "DepreciationAmortizationDepletionIncomeStatement",
        "DepreciationAndAmortizationInIncomeStatement",
        "DepreciationIncomeStatement",
        "DilutedAccountingChange",
        "DilutedAverageShares",
        "DilutedContinuousOperations",
        "DilutedDiscontinuousOperations",
        "DilutedEPS",
        "DilutedEPSOtherGainsLosses",
        "DilutedExtraordinary",
        "DilutedNIAvailtoComStockholders",
        "DividendPerShare",
        "EBIT",
        "EBITDA",
        "EarningsFromEquityInterest",
        "EarningsFromEquityInterestNetOfTax",
        "ExciseTaxes",
        "GainOnSaleOfBusiness",
        "GainOnSaleOfPPE",
        "GainOnSaleOfSecurity",
        "GeneralAndAdministrativeExpense",
        "GrossProfit",
        "ImpairmentOfCapitalAssets",
        "InsuranceAndClaims",
        "InterestExpense",
        "InterestExpenseNonOperating",
        "InterestIncome",
        "InterestIncomeNonOperating",
        "MinorityInterests",
        "NetIncome",
        "NetIncomeCommonStockholders",
        "NetIncomeContinuousOperations",
        "NetIncomeDiscontinuousOperations",
        "NetIncomeExtraordinary",
        "NetIncomeFromContinuingAndDiscontinuedOperation",
        "NetIncomeFromContinuingOperationNetMinorityInterest",
        "NetIncomeFromTaxLossCarryforward",
        "NetIncomeIncludingNoncontrollingInterests",
        "NetInterestIncome",
        "NetNonOperatingInterestIncomeExpense",
        "NormalizedBasicEPS",
        "NormalizedDilutedEPS",
        "NormalizedEBITDA",
        "NormalizedIncome",
        "OperatingExpense",
        "OperatingIncome",
        "OperatingRevenue",
        "OtherGandA",
        "OtherIncomeExpense",
        "OtherNonOperatingIncomeExpenses",
        "OtherOperatingExpenses",
        "OtherSpecialCharges",
        "OtherTaxes",
        "OtherunderPreferredStockDividend",
        "PreferredStockDividends",
        "PretaxIncome",
        "ProvisionForDoubtfulAccounts",
        "ReconciledCostOfRevenue",
        "ReconciledDepreciation",
        "RentAndLandingFees",
        "RentExpenseSupplemental",
        "ReportedNormalizedBasicEPS",
        "ReportedNormalizedDilutedEPS",
        "ResearchAndDevelopment",
        "RestructuringAndMergernAcquisition",
        "SalariesAndWages",
        "SecuritiesAmortization",
        "SellingAndMarketingExpense",
        "SellingGeneralAndAdministration",
        "SpecialIncomeCharges",
        "TaxEffectOfUnusualItems",
        "TaxLossCarryforwardBasicEPS",
        "TaxLossCarryforwardDilutedEPS",
        "TaxProvision",
        "TaxRateForCalcs",
        "TotalExpenses",
        "TotalOperatingIncomeAsReported",
        "TotalOtherFinanceCost",
        "TotalRevenue",
        "TotalUnusualItems",
        "TotalUnusualItemsExcludingGoodwill",
        "WriteOff",
    ],
    "balance_sheet"=> [
        "AccountsPayable",
        "AccountsReceivable",
        "AccruedInterestReceivable",
        "AccumulatedDepreciation",
        "AdditionalPaidInCapital",
        "AllowanceForDoubtfulAccountsReceivable",
        "AssetsHeldForSaleCurrent",
        "AvailableForSaleSecurities",
        "BuildingsAndImprovements",
        "CapitalLeaseObligations",
        "CapitalStock",
        "CashAndCashEquivalents",
        "CashCashEquivalentsAndShortTermInvestments",
        "CashEquivalents",
        "CashFinancial",
        "CommercialPaper",
        "CommonStock",
        "CommonStockEquity",
        "ConstructionInProgress",
        "CurrentAccruedExpenses",
        "CurrentAssets",
        "CurrentCapitalLeaseObligation",
        "CurrentDebt",
        "CurrentDebtAndCapitalLeaseObligation",
        "CurrentDeferredAssets",
        "CurrentDeferredLiabilities",
        "CurrentDeferredRevenue",
        "CurrentDeferredTaxesAssets",
        "CurrentDeferredTaxesLiabilities",
        "CurrentLiabilities",
        "CurrentNotesPayable",
        "CurrentProvisions",
        "DefinedPensionBenefit",
        "DerivativeProductLiabilities",
        "DividendsPayable",
        "DuefromRelatedPartiesCurrent",
        "DuefromRelatedPartiesNonCurrent",
        "DuetoRelatedPartiesCurrent",
        "DuetoRelatedPartiesNonCurrent",
        "EmployeeBenefits",
        "FinancialAssets",
        "FinancialAssetsDesignatedasFairValueThroughProfitorLossTotal",
        "FinishedGoods",
        "FixedAssetsRevaluationReserve",
        "ForeignCurrencyTranslationAdjustments",
        "GainsLossesNotAffectingRetainedEarnings",
        "GeneralPartnershipCapital",
        "Goodwill",
        "GoodwillAndOtherIntangibleAssets",
        "GrossAccountsReceivable",
        "GrossPPE",
        "HedgingAssetsCurrent",
        "HeldToMaturitySecurities",
        "IncomeTaxPayable",
        "InterestPayable",
        "InventoriesAdjustmentsAllowances",
        "Inventory",
        "InvestedCapital",
        "InvestmentProperties",
        "InvestmentinFinancialAssets",
        "InvestmentsAndAdvances",
        "InvestmentsInOtherVenturesUnderEquityMethod",
        "InvestmentsinAssociatesatCost",
        "InvestmentsinJointVenturesatCost",
        "InvestmentsinSubsidiariesatCost",
        "LandAndImprovements",
        "Leases",
        "LiabilitiesHeldforSaleNonCurrent",
        "LimitedPartnershipCapital",
        "LineOfCredit",
        "LoansReceivable",
        "LongTermCapitalLeaseObligation",
        "LongTermDebt",
        "LongTermDebtAndCapitalLeaseObligation",
        "LongTermEquityInvestment",
        "LongTermProvisions",
        "MachineryFurnitureEquipment",
        "MinimumPensionLiabilities",
        "MinorityInterest",
        "NetDebt",
        "NetPPE",
        "NetTangibleAssets",
        "NonCurrentAccountsReceivable",
        "NonCurrentAccruedExpenses",
        "NonCurrentDeferredAssets",
        "NonCurrentDeferredLiabilities",
        "NonCurrentDeferredRevenue",
        "NonCurrentDeferredTaxesAssets",
        "NonCurrentDeferredTaxesLiabilities",
        "NonCurrentNoteReceivables",
        "NonCurrentPensionAndOtherPostretirementBenefitPlans",
        "NonCurrentPrepaidAssets",
        "NotesReceivable",
        "OrdinarySharesNumber",
        "OtherCapitalStock",
        "OtherCurrentAssets",
        "OtherCurrentBorrowings",
        "OtherCurrentLiabilities",
        "OtherEquityAdjustments",
        "OtherEquityInterest",
        "OtherIntangibleAssets",
        "OtherInventories",
        "OtherInvestments",
        "OtherNonCurrentAssets",
        "OtherNonCurrentLiabilities",
        "OtherPayable",
        "OtherProperties",
        "OtherReceivables",
        "OtherShortTermInvestments",
        "Payables",
        "PayablesAndAccruedExpenses",
        "PensionandOtherPostRetirementBenefitPlansCurrent",
        "PreferredSecuritiesOutsideStockEquity",
        "PreferredSharesNumber",
        "PreferredStock",
        "PreferredStockEquity",
        "PrepaidAssets",
        "Properties",
        "RawMaterials",
        "Receivables",
        "ReceivablesAdjustmentsAllowances",
        "RestrictedCash",
        "RestrictedCommonStock",
        "RetainedEarnings",
        "ShareIssued",
        "StockholdersEquity",
        "TangibleBookValue",
        "TaxesReceivable",
        "TotalAssets",
        "TotalCapitalization",
        "TotalDebt",
        "TotalEquityGrossMinorityInterest",
        "TotalLiabilitiesNetMinorityInterest",
        "TotalNonCurrentAssets",
        "TotalNonCurrentLiabilitiesNetMinorityInterest",
        "TotalPartnershipCapital",
        "TotalTaxPayable",
        "TradeandOtherPayablesNonCurrent",
        "TradingSecurities",
        "TreasurySharesNumber",
        "TreasuryStock",
        "UnrealizedGainLoss",
        "WorkInProcess",
        "WorkingCapital",
    ],
    "cash_flow"=> [
        "AdjustedGeographySegmentData",
        "AmortizationCashFlow",
        "AmortizationOfIntangibles",
        "AmortizationOfSecurities",
        "AssetImpairmentCharge",
        "BeginningCashPosition",
        "CapitalExpenditure",
        "CapitalExpenditureReported",
        "CashDividendsPaid",
        "CashFlowFromContinuingFinancingActivities",
        "CashFlowFromContinuingInvestingActivities",
        "CashFlowFromContinuingOperatingActivities",
        "CashFlowFromDiscontinuedOperation",
        "CashFlowsfromusedinOperatingActivitiesDirect",
        "CashFromDiscontinuedFinancingActivities",
        "CashFromDiscontinuedInvestingActivities",
        "CashFromDiscontinuedOperatingActivities",
        "ChangeInAccountPayable",
        "ChangeInAccruedExpense",
        "ChangeInCashSupplementalAsReported",
        "ChangeInDividendPayable",
        "ChangeInIncomeTaxPayable",
        "ChangeInInterestPayable",
        "ChangeInInventory",
        "ChangeInOtherCurrentAssets",
        "ChangeInOtherCurrentLiabilities",
        "ChangeInOtherWorkingCapital",
        "ChangeInPayable",
        "ChangeInPayablesAndAccruedExpense",
        "ChangeInPrepaidAssets",
        "ChangeInReceivables",
        "ChangeInTaxPayable",
        "ChangeInWorkingCapital",
        "ChangesInAccountReceivables",
        "ChangesInCash",
        "ClassesofCashPayments",
        "ClassesofCashReceiptsfromOperatingActivities",
        "CommonStockDividendPaid",
        "CommonStockIssuance",
        "CommonStockPayments",
        "DeferredIncomeTax",
        "DeferredTax",
        "Depletion",
        "Depreciation",
        "DepreciationAmortizationDepletion",
        "DepreciationAndAmortization",
        "DividendPaidCFO",
        "DividendReceivedCFO",
        "DividendsPaidDirect",
        "DividendsReceivedCFI",
        "DividendsReceivedDirect",
        "DomesticSales",
        "EarningsLossesFromEquityInvestments",
        "EffectOfExchangeRateChanges",
        "EndCashPosition",
        "ExcessTaxBenefitFromStockBasedCompensation",
        "FinancingCashFlow",
        "ForeignSales",
        "FreeCashFlow",
        "GainLossOnInvestmentSecurities",
        "GainLossOnSaleOfBusiness",
        "GainLossOnSaleOfPPE",
        "IncomeTaxPaidSupplementalData",
        "InterestPaidCFF",
        "InterestPaidCFO",
        "InterestPaidDirect",
        "InterestPaidSupplementalData",
        "InterestReceivedCFI",
        "InterestReceivedCFO",
        "InterestReceivedDirect",
        "InvestingCashFlow",
        "IssuanceOfCapitalStock",
        "IssuanceOfDebt",
        "LongTermDebtIssuance",
        "LongTermDebtPayments",
        "NetBusinessPurchaseAndSale",
        "NetCommonStockIssuance",
        "NetForeignCurrencyExchangeGainLoss",
        "NetIncome",
        "NetIncomeFromContinuingOperations",
        "NetIntangiblesPurchaseAndSale",
        "NetInvestmentPropertiesPurchaseAndSale",
        "NetInvestmentPurchaseAndSale",
        "NetIssuancePaymentsOfDebt",
        "NetLongTermDebtIssuance",
        "NetOtherFinancingCharges",
        "NetOtherInvestingChanges",
        "NetPPEPurchaseAndSale",
        "NetPreferredStockIssuance",
        "NetShortTermDebtIssuance",
        "OperatingCashFlow",
        "OperatingGainsLosses",
        "OtherCashAdjustmentInsideChangeinCash",
        "OtherCashAdjustmentOutsideChangeinCash",
        "OtherCashPaymentsfromOperatingActivities",
        "OtherCashReceiptsfromOperatingActivities",
        "OtherNonCashItems",
        "PaymentsonBehalfofEmployees",
        "PaymentstoSuppliersforGoodsandServices",
        "PensionAndEmployeeBenefitExpense",
        "PreferredStockDividendPaid",
        "PreferredStockIssuance",
        "PreferredStockPayments",
        "ProceedsFromStockOptionExercised",
        "ProvisionandWriteOffofAssets",
        "PurchaseOfBusiness",
        "PurchaseOfIntangibles",
        "PurchaseOfInvestment",
        "PurchaseOfInvestmentProperties",
        "PurchaseOfPPE",
        "ReceiptsfromCustomers",
        "ReceiptsfromGovernmentGrants",
        "RepaymentOfDebt",
        "RepurchaseOfCapitalStock",
        "SaleOfBusiness",
        "SaleOfIntangibles",
        "SaleOfInvestment",
        "SaleOfInvestmentProperties",
        "SaleOfPPE",
        "ShortTermDebtIssuance",
        "ShortTermDebtPayments",
        "StockBasedCompensation",
        "TaxesRefundPaid",
        "TaxesRefundPaidDirect",
        "UnrealizedGainLossOnInvestmentSecurities",
    ],
    "valuation"=> [
        "EnterprisesValueEBITDARatio",
        "EnterprisesValueRevenueRatio",
        "EnterpriseValue",
        "EBITDA",
        "EBIT",
        "ForwardPeRatio",
        "PeRatio",
        "PsRatio",
        "PbRatio",
        "PegRatio",
        "MarketCap"
    ]
)

_Fundamental_Intervals = [
    "annual",
    "quarterly",
    "monthly",
]

_Fundamental_Tables = [
    "income_statement",
    "balance_sheet",
    "cash_flow",
    "valuation"
]


"""
    fundamentals(symbol::AbstractString, item::AbstractString, interval::AbstractString, startdt, enddt)

Retrieves financial statement information from Yahoo Finance for a given symbol, accounting item, accounting period, and date range.

# Arguments

 * `symbol::String` is a ticker (e.g. "GS" for Goldman Sachs, or "^GSPC" for the S&P500 index)

 * `item::String` can either be an entire financial statement or an item. Entire financial statements:`"income_statement", "cash_flow", "balance_sheet"` or "valuation". To see valid items grouped by financial statement call `_Fundamental_Types`

 * `interval::String` can be one of "annual", "quarterly", "monthly"

 * `startdt` and `enddt` take the following types: `::Date`,`::DateTime`, or a `String` of the following form `yyyy-mm-dd` (e.g. Date(2025,01,01) or "2025-01-01")

# Returns

* `symbol, item, res` where `res` is a JSON object containing the financial statement information   

# Examples
```julia-repl
julia> fundamentals("TSLA", "income_statement","annual","2021-01-01","2025-12-31")

julia> fundamentals("IBM", "InterestExpense","quarterly","2004-01-01","2024-12-31")
```
"""
function fundamentals(symbol::AbstractString, item::AbstractString, interval::AbstractString, startdt, enddt)
    # Check if symbol is valid
    old_symbol = symbol
    symbol = valid_symbols(symbol)
    if isempty(symbol)
        @warn "$old_symbol is not a valid Symbol. Returning an empty JSON object!"
        return JSON3.Object(), symbol, item
    else
        symbol = symbol[1]
    end

    # Check Start and End dates.
    if !isequal(startdt,"") || !isequal(enddt,"")
        startdt, enddt = _date_to_unix(startdt), _date_to_unix(enddt)
    end
    @assert in(interval, _Fundamental_Intervals) "Chosen interval is not supported. Choose one of: annual, quarterly, monthly"

    # Build Query:
    if in(item, keys(_Fundamental_Types))
        entire_statement = true
        query_items = join(string.(interval,_Fundamental_Types[item]), ",")
    else
        entire_statement = false
        @assert in(item, vcat([_Fundamental_Types[i] for i in keys(_Fundamental_Types)]...)) "Chosen item is not supported. View supported items by calling _Fundamental_Types"
        query_items = string(interval, item)
    end
    q = Dict(
        "symbol" => symbol,
        "type" => query_items,
        "period1" => startdt,
        "period2" => enddt,
        "formatted" => "false"
    )
    url = "https://query2.finance.yahoo.com/ws/fundamentals-timeseries/v1/finance/timeseries/$(symbol)"
    
    try
        res = HTTP.get(url, query=q, proxy=_PROXY_SETTINGS[:proxy], headers=_PROXY_SETTINGS[:auth])
        res = JSON3.read(res.body)
        return symbol, item, res
    catch e
        if isa(e, HTTP.Exceptions.StatusError) && e.status == 404
            println("❌ No \"$interval\" data available for \"$item\". Try \"quarterly\" or \"annual\" instead.")
            return  symbol, item, JSON3.Object()  
        else
            rethrow()  # If it's another error, rethrow it
        end
    end
end
get_income_statement(symbol::AbstractString, interval::AbstractString, startdt, enddt) = fundamentals(symbol, "income_statement", interval, startdt, enddt)[3]
get_income_statement(symbol::AbstractString, interval::AbstractString) = fundamentals(symbol, "income_statement", interval, "2000-01-01", today())[3]
get_income_statement(symbol::AbstractString) = fundamentals(symbol, "income_statement", "annual", "2000-01-01", today())[3]

get_cash_flow(symbol::AbstractString, interval::AbstractString, startdt, enddt) = fundamentals(symbol, "cash_flow", interval, startdt, enddt)[3]
get_cash_flow(symbol::AbstractString, interval::AbstractString) = fundamentals(symbol, "cash_flow", interval, "2000-01-01", today())[3]
get_cash_flow(symbol::AbstractString) = fundamentals(symbol, "cash_flow", "annual", "2000-01-01", today())[3]

get_balance_sheet(symbol::AbstractString, interval::AbstractString, startdt, enddt) = fundamentals(symbol, "balance_sheet", interval, startdt, enddt)[3]
get_balance_sheet(symbol::AbstractString, interval::AbstractString) = fundamentals(symbol, "balance_sheet", interval, "2000-01-01", today())[3]
get_balance_sheet(symbol::AbstractString) = fundamentals(symbol, "balance_sheet", "annual", "2000-01-01", today())[3]

get_valuation(symbol::AbstractString, interval::AbstractString, startdt, enddt) = fundamentals(symbol, "valuation", interval, startdt, enddt)[3]
get_valuation(symbol::AbstractString, interval::AbstractString) = fundamentals(symbol, "valuation", interval, "2000-01-01", today())[3]
get_valuation(symbol::AbstractString) = fundamentals(symbol, "valuation", "annual", "2000-01-01", today())[3]


"""
    db_insert(conn, table, json_data)

Inserts data into the following tables: income_statement, cash_flow, balance_sheet and valuatiuon
"""
function db_insert(conn, table, json_data)
    new_rows = 0
    skipped_rows = 0
    skipped_examples = []
    symbol = ""

    # Process each result in the JSON data
    for result in json_data.timeseries.result
        symbol = result.meta.symbol[1]
        type_ = result.meta.type[1]
        type_cleaned = replace(type_, r"^(annual|quarterly|monthly)" => "")
        financial_data = get(result, Symbol(type_), [])

        for value in financial_data
            reported_value_raw = value.reportedValue.raw
            currency_code = get(value, :currencyCode, missing)
            period = value.periodType

            # Check if the row already exists in the database
            exists_query = """
            SELECT COUNT(*) FROM $(table) 
            WHERE symbol = ? AND item = ? AND period = ? AND asOfDate = ?;
            """
            row_exists = DBInterface.execute(conn, exists_query, (symbol, type_cleaned, period, value.asOfDate)) |> DataFrame

            if row_exists[1, 1] > 0
                skipped_rows += 1
                if length(skipped_examples) < 3
                    push!(skipped_examples, (symbol, type_cleaned, period, value.asOfDate))
                end
                continue
            end

            # Insert new row if it doesn't exist
            query = """
            INSERT INTO $(table) (symbol, item, asOfDate, period, currency, value)
            VALUES (?, ?, ?, ?, ?, ?);
            """
            DBInterface.execute(conn, query, (symbol, type_cleaned, value.asOfDate, period, currency_code, reported_value_raw))
            new_rows += 1
        end
    end

    # Build summary using IOBuffer for efficient concatenation
    io_buffer = IOBuffer()
    println(io_buffer, "\n✅ Insert summary for $(symbol) $(table) table")
    println(io_buffer, "   - New rows added: $(new_rows)")
    println(io_buffer, "   - Skipped duplicates: $(skipped_rows)")

    if !isempty(skipped_examples)
        println(io_buffer, "   - Example skipped rows:")
        for ex in skipped_examples
            println(io_buffer, "      - Symbol: $(ex[1]), Item: $(ex[2]), Period: $(ex[3]), Date: $(ex[4])")
        end
    end

    # Print all at once for better performance
    println(String(take!(io_buffer)))

    return nothing
end



"""
    db_save(conn, table, output_directory::String; format = "xlsx")
"""
function db_save(conn, table, output_directory::String; format = "xlsx")
    if !(table in _Fundamental_Tables)
        println("❌ Table '$table' does not exist!")
        println("✅ Available tables: ", join(_Fundamental_Tables, ", "))
        return nothing  # Prevent catastrophic failure
    end

    if  lowercase(format) == "csv"
        # Save a table from SQLite or DuckDB databases in CSV format
        # Create the output directory if it doesn't exist
        mkpath(output_directory)  # Create the output directory if it doesn't exist
        file_path = joinpath(output_directory, "$table.csv") # Construct the file path
        export_table_to_csv(conn, table, file_path)
        println("✅ Saved to csv: $file_path")

    elseif lowercase(format) == "xlsx"
        if conn isa DuckDB.DB
            duckdb_to_excel(conn, table, output_directory)
        end

    elseif lowercase(format) == "parquet"
        if conn isa DuckDB.DB
            mkpath(output_directory)  # Create the output directory if it doesn't exist
            file_path = joinpath(output_directory, "$table.parquet") # Construct the file path
            DBInterface.execute(conn, "COPY $table TO '$file_path' (FORMAT 'parquet')")
            println("✅ Saved to Parquet: $file_path")
        end
    else 
        println("❌ This format is not supported by db_save. Please use one of the following supported formats: XLSX, DuckDB, CSV or Parquet. XLSX and DuckDB allow to save more than one table in the same file. CSV is human-readable formats.")
    end
end


"""
    db_save(conn, output_directory::String)

Saves the whole DuckDB database to a workbook
"""
function db_save(conn, file_path::String = default_filename(conn))
    if !(conn isa DuckDB.DB)
        println("❌ The provided database is not a DuckDB database, skipping Save to Excel")
        println("✅ Save to Excel is supported by the following database types: DuckDB.DB")
        return
    end

    # Get the list of tables in the database
    tables_result = DuckDB.execute(conn, "SHOW TABLES;")
    tables = [row[1] for row in tables_result]

    # Move "Company_profile" to the front if it exists
    company_profile_index = findfirst(t -> lowercase(t) == "summary_profile", lowercase.(tables))
    if !isnothing(company_profile_index)
        company_profile = splice!(tables, company_profile_index)
        pushfirst!(tables, company_profile)
    end

    XLSX.openxlsx(file_path, mode="w") do xf
        for (index, table) in enumerate(tables)
            df = DuckDB.execute(conn, "SELECT * FROM $table") |> DataFrame
            
            if index == 1
                sheet = xf[1]  # Use the first sheet for the first table
                XLSX.rename!(sheet, table)
            else
                sheet = XLSX.addsheet!(xf, table)
            end
            
            XLSX.writetable!(sheet, collect(DataFrames.eachcol(df)), names(df))
        end
    end

    println("✅ Saved to Excel (all tables): $(file_path)")
end
function default_filename(conn)
    db_path = conn.handle.file  # Example: "/path/to/database.duckdb"
    base, _ = splitext(db_path) # Splits "/path/to/database" and ".duckdb"
    return base * ".xlsx"
end
"""
    duckdb_to_excel(conn, table::String, output_directory::String)

Saves the table to an Excel workbook with the same name as the table and extension .xlsx
"""
function duckdb_to_excel(conn, table::String, output_directory::String)
    if !(conn isa DuckDB.DB)
        println("❌ The provided database is not a DuckDB database, skipping Save to Excel")
        println("✅ Save to Excel is supported by the following database types: DuckDB.DB")
        return
    end

    mkpath(output_directory) # Create the output directory if it doesn't exist
    file_path = joinpath(output_directory, "$(table).xlsx")     # Construct the file path

    # Check if the table exists
    table_exists = DuckDB.execute(conn, "SELECT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = '$table')") |> DataFrame
    if !table_exists[1, 1]
        println("❌ Table '$table' does not exist in the database.")
        return
    end

    try
        XLSX.openxlsx(file_path, mode="w") do xf
            df = DuckDB.execute(conn, "SELECT * FROM $table") |> DataFrame
            sheet = xf[1]  # Get first sheet
            XLSX.writetable!(sheet, collect(DataFrames.eachcol(df)), names(df))
            XLSX.rename!(sheet, table)  # Rename sheet to match table name
        end
        println("✅ Saved to Excel: $file_path")
    catch e
        println("❌ Error saving table '$table' to Excel: $(e)")
    end
end


"""
    income_statement(raw_df::DataFrame, n) -> DataFrame

Given a DataFrame `raw_df` with raw income statement items, this function
constructs a standardized income statement DataFrame with the following rows:

1. Total Revenue
2. Cost of Revenue (COGS)
3. Gross Profit
4. Operating Expenses
5. Selling, General and Administration
6. R&D
7. Other Operating Expenses
8. Operating Income
9. Interest Expense
10. Interest Income (Non-Operating)
11. Other Non-Operating Income/Expense
12. Pre-Tax Income (EBT)
13. Income Tax Expense
14. Net Income
15. Basic EPS
16. Diluted EPS
"""
function income_statement(raw_df::DataFrame, n)
    # Map the necessary items from the raw DataFrame.
    # Adjust these names to match your raw data column names.

    period_label   = raw_df[n,1]

    total_revenue  = raw_df.TotalRevenue[n]
    cost_revenue   = raw_df.CostOfRevenue[n]
    gross_profit   = raw_df.GrossProfit[n]
    sgna           = raw_df.SellingGeneralAndAdministration[n]  # SG&A
    rnd            = raw_df.ResearchAndDevelopment[n]           # R&D
    # If you have a separate "OtherOperatingExpenses", you can include that;
    # Otherwise, assume it is included in SG&A or R&D.
    other_opex     = hasproperty(raw_df, :OtherOperatingExpenses) ? raw_df.OtherOperatingExpenses[n] : 0.0

    # Operating Expenses: Sum of SG&A, R&D, and Other Operating Expenses
    operating_expenses = sgna + rnd + other_opex

    # EBIT is typically reported as Operating Income in raw data.
    # You may want to compute it as:
    # EBIT = Gross Profit - Operating Expenses
    # If raw_df already provides EBIT (for example, "OperatingIncome"), use that
    operating_income = hasproperty(raw_df, :OperatingIncome) ? raw_df.OperatingIncome[n] : gross_profit - operating_expenses
    # More sophisticed Version
    # EBIT = get_EBIT(raw_df, n)


    # D&A may be reported as "Depreciation & Amortization" or "ReconciledDepreciation".
    DnA = hasproperty(raw_df, :DepreciationAndAmortization) ? raw_df.DepreciationAndAmortization[n] :
          hasproperty(raw_df, :ReconciledDepreciation)    ? raw_df.ReconciledDepreciation[n] :
          0.0

    # Compute EBITDA as EBIT + D&A.
    # EBITDA = operating_income + DnA

    # Other items:
    interest_expense = raw_df.InterestExpense[n]

    interest_income_no = hasproperty(raw_df, :InterestIncomeNonOperating) ? raw_df.InterestIncomeNonOperating[n] : 0.0
    interest_income = hasproperty(raw_df, :InterestIncome) ? raw_df.InterestIncome[n] : 0.0

    # For simplicity, let’s combine any interest income with other non-operating income.
    other_nonoperating = hasproperty(raw_df, :OtherNonOperatingIncomeExpenses) ? raw_df.OtherNonOperatingIncomeExpenses[n] : 0.0
    pre_tax_income   = hasproperty(raw_df, :PretaxIncome) ? raw_df.PretaxIncome[n] : operating_income + interest_income_no - interest_expense + other_nonoperating
    tax_expense      = raw_df.TaxProvision[n]  # or IncomeTaxExpense
    net_income       = raw_df.NetIncome[n]

    basic_EPS        = raw_df.BasicEPS[n]
    diluted_EPS      = raw_df.DilutedEPS[n]

    # Construct the standardized income statement as a DataFrame.
    is_categories = [
        "+ Total Revenue",
        "- Cost of Revenue (COGS)",
        "= Gross Profit",
        "- Operating Expenses",
        "    Selling, General and Administration",
        "    R&D",
        "    Other Operating Expenses",
        "= Operating Income",
        "+ Interest Income (Non-Operating)",
        "- Interest Expense",
        "+ Other Non-Operating Income/Expense",
        "= Pre-Tax Income",
        "- Income Tax Provision",
        "= Net Income",
        "Basic EPS",
        "Diluted EPS"
    ]

    is_amounts = [
        total_revenue/1_000_000,
        cost_revenue/1_000_000,
        gross_profit/1_000_000,
        operating_expenses/1_000_000,
        sgna/1_000_000,
        rnd/1_000_000,
        other_opex/1_000_000,
        operating_income/1_000_000,
        interest_income_no/1_000_000,
        interest_expense/1_000_000,
        other_nonoperating/1_000_000,
        pre_tax_income/1_000_000,
        tax_expense/1_000_000,
        net_income/1_000_000,
        basic_EPS,
        diluted_EPS
    ]

    col_names = [:FinancialStatement, Symbol(period_label)]
    col_data = [is_categories, is_amounts]
    return DataFrame(col_names .=> col_data)
end

function valuation(raw_df::DataFrame, n)
    period_label    = raw_df[n,1]
    ev2ebitda       = raw_df.EnterprisesValueEBITDARatio[n]
    ev2revenues     = raw_df.EnterprisesValueRevenueRatio[n]
    ev              = raw_df.EnterpriseValue[n]/1_000_000
    ebitda          = raw_df.EBITDA[n]/1_000_000
    ebit            = raw_df.EBIT[n]/1_000_000
    ev2ebit         = hasproperty(raw_df, :EnterprisesValueEBITRatio) ? raw_df.EnterprisesValueEBITRatio[n] : ev/ebit
    fper            = raw_df.ForwardPeRatio[n]
    per             = raw_df.PeRatio[n]
    psr             = raw_df.PsRatio[n]
    pbr             = raw_df.PbRatio[n]
    peg             = raw_df.PegRatio[n]
    mc              = raw_df.MarketCap[n]/1_000_000


    v_categories = [
        "EV/EBITDA Ratio",
        "EV/EBIT Ratio",
        "EV/Revenue Ratio",
        "EV",
        "EBITDA",
        "EBIT",
        "Forward P/E",
        "P/E",
        "P/Sales",
        "P/Book",
        "PEG",
        "Equity Market Capitalization"
    ]

    v_amounts = [
        ev2ebitda,
        ev2ebit,
        ev2revenues,
        ev,
        ebitda,
        ebit,
        fper,
        per,
        psr,
        pbr,
        peg,
        mc
    ]

    col_names = [:ValuationMetrics, Symbol(period_label)]
    col_data = [v_categories, v_amounts]
    return DataFrame(col_names .=> col_data)
end