
"""
    db_create(db_path, dbtype = "duckdb")

Creates a database file (db_path) for the specified database type: `"duckdb"` (default) or `"sqlite"`. 

# Arguments:
- db_path: The path to the database file.
- dbtype: A symbol specifying the database type. Supported values are `:duckdb` and `:sqlite`.

Returns:
- A database connection object.
"""

function db_create(db_path::String, dbtype::String = "duckdb")
    # Need to allow dbtype = "sqlite"
    # dbtype = "duckdb"
    if lowercase(dbtype) == "duckdb"
        conn = DuckDB.DB(db_path) # Opens existing or creates if missing

        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS income_statement (
            symbol          VARCHAR NOT NULL,
            item            VARCHAR NOT NULL,
            currency        VARCHAR,
            period          VARCHAR NOT NULL,
            asOfDate        VARCHAR NOT NULL,
            value           DOUBLE,
            PRIMARY KEY (symbol, item, period, asOfDate)
            );
        """)

        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS balance_sheet (
            symbol          VARCHAR NOT NULL,
            item            VARCHAR NOT NULL,
            currency        VARCHAR,
            period          VARCHAR NOT NULL,
            asOfDate        VARCHAR NOT NULL,
            value           DOUBLE,
            PRIMARY KEY (symbol, item, period, asOfDate)
            );
        """)

        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS cash_flow (
            symbol          VARCHAR NOT NULL,
            item            VARCHAR NOT NULL,
            currency        VARCHAR,
            period          VARCHAR NOT NULL,
            asOfDate        VARCHAR NOT NULL,
            value           DOUBLE,
            PRIMARY KEY (symbol, item, period, asOfDate)
            );
        """)

        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS valuation (
            symbol          VARCHAR NOT NULL,
            item            VARCHAR NOT NULL,
            currency        VARCHAR,
            period          VARCHAR NOT NULL,
            asOfDate        VARCHAR NOT NULL,
            value           DOUBLE,
            PRIMARY KEY (symbol, item, period, asOfDate)
            );
        """)

        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS sec_filings (
            symbol                  VARCHAR NOT NULL,
            date                    DATE,
            type                    VARCHAR,
            title                   VARCHAR,
            edgarUrl                VARCHAR,
            exhibit_type            VARCHAR,
            exhibit_url             VARCHAR,
            exhibit_downloadUrl     VARCHAR
            );
        """)
        
        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS entity_profile (
            symbol                      VARCHAR NOT NULL,
            country                     VARCHAR, 
            sector                      VARCHAR, 
            industry                    VARCHAR, 
            businessSummary             VARCHAR, 
            employees                   INTEGER,
            website                     VARCHAR, 
            irWebsite                   VARCHAR  
            );
        """)

        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS quote_type (
            shortName                   VARCHAR,
            symbol                      VARCHAR, 
            underlyingSymbol            VARCHAR, 
            quoteType                   VARCHAR, 
            exchange                    VARCHAR, 
            firstTrade                  DATE,    
            timeZoneShortName           VARCHAR,
            gmtOffset                   SMALLINT
            );
        """)
        
        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS key_statistics (
            symbol                      VARCHAR NOT NULL,
            today                       DATE,
            lastFiscalYearEnd           DATE,
            mostRecentQuarter           DATE,
            trailingEps                 FLOAT,
            forwardEps                  FLOAT,
            bookValueps                 FLOAT,
            enterpriseToRevenue         FLOAT,      
            enterpriseToEbitda          FLOAT,
            profitMargins               FLOAT,
            earningsQuarterlyGrowt      FLOAT,
            beta                        FLOAT,
            insidersPercentHeld         FLOAT,
            institutionsPercentHeld     FLOAT,
            legalType                   VARCHAR,
            fundFamily                  VARCHAR
            );
        """)

        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS target_prices (
            symbol                      VARCHAR NOT NULL,
            today                       DATE,
            currentPrice                FLOAT, 
            targetHighPrice             FLOAT, 
            targetLowPrice              FLOAT,  
            targetMeanPrice             FLOAT, 
            targetMedianPrice           FLOAT, 
            numberOfAnalystOpinions     SMALLINT
            );
        """)

        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS institutional_ownership (
            symbol          VARCHAR NOT NULL,
            organization    VARCHAR,
            reportDate      DATE,
            pctHeld         FLOAT,
            position        BIGINT,
            value           BIGINT,
            pctChange       FLOAT
            );
        """)

        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS fund_ownership (
            symbol          VARCHAR NOT NULL,
            organization    VARCHAR,
            reportDate      DATE,
            pctHeld         FLOAT,
            position        BIGINT,
            value           BIGINT,
            pctChange       FLOAT
            );
        """)

        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS eps_estimates (
            symbol          VARCHAR NOT NULL,
            quarter         VARCHAR,
            epsEstimate     FLOAT,
            epsActual       FLOAT
            );
        """)

        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS recommendation_trend (
            symbol      VARCHAR NOT NULL,
            today       DATE,
            period      VARCHAR,
            strongbuy   INTEGER,
            buy         INTEGER,
            hold        INTEGER,
            sell        INTEGER,
            strongsell  INTEGER
            );
        """)

        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS upgrade_downgrade_history (
            symbol      VARCHAR NOT NULL,
            firm        VARCHAR NOT NULL,
            date        DATE,
            toGrade     VARCHAR,
            fromGrade   VARCHAR,
            action      VARCHAR
            );
        """)

        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS esg_scores (
            symbol                  VARCHAR NOT NULL,
            date                    DATE, 
            esgScore                FLOAT,
            governanceScore         FLOAT,
            environmentScore        FLOAT,
            socialScore             FLOAT,
            esgScorePeers           FLOAT,
            governanceScorePeers    FLOAT,
            environmentScorePeers   FLOAT,
            socialScorePeers        FLOAT
            );
        """)

    elseif lowercase(dbtype) == "sqlite"
        conn = SQLite.DB(db_path)
        # SQLite uses INTEGER for boolean (0=false, 1=true)
        # We use TEXT for Date and DateTime

        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS income_statement (
            symbol      TEXT NOT NULL,
            item        TEXT NOT NULL,
            currency    TEXT,
            period      TEXT NOT NULL,
            asOfDate    TEXT NOT NULL,
            value       REAL,
            PRIMARY KEY (symbol, item, period, asOfDate)
            );
        """)
        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS balance_sheet (
            symbol      TEXT NOT NULL,
            item        TEXT NOT NULL,
            currency    TEXT,
            period      TEXT NOT NULL,
            asOfDate    TEXT NOT NULL,
            value       REAL,
            PRIMARY KEY (symbol, item, period, asOfDate)
            );
        """)
        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS cash_flow (
            symbol      TEXT NOT NULL,
            item        TEXT NOT NULL,
            currency    TEXT,
            period      TEXT NOT NULL,
            asOfDate    TEXT NOT NULL,
            value       REAL,
            PRIMARY KEY (symbol, item, period, asOfDate)
            );
        """)

        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS valuation (
            symbol      TEXT NOT NULL,
            item        TEXT NOT NULL,
            currency    TEXT,
            period      TEXT NOT NULL,
            asOfDate    TEXT NOT NULL,
            value       REAL,
            PRIMARY KEY (symbol, item, period, asOfDate)
            );
        """)

        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS sec_filings (
            symbol                  TEXT NOT NULL,
            date                    TEXT,
            type                    TEXT,
            title                   TEXT,
            edgarUrl                TEXT,
            exhibit_type            TEXT,
            exhibit_url             TEXT,
            exhibit_downloadUrl     TEXT
            );
        """)

        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS summary_profile (
            symbol                      TEXT NOT NULL,
            country                     TEXT, 
            sector                      TEXT, 
            industry                    TEXT, 
            businessSummary             TEXT, 
            employees                   INTEGER,
            website                     TEXT, 
            irWebsite                   TEXT  
            );
        """)

        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS quote_type (
            shortName                   TEXT,
            symbol                      TEXT, 
            underlyingSymbol            TEXT, 
            quoteType                   TEXT, 
            exchange                    TEXT, 
            firstTrade                  DATE,    
            timeZoneShortName           TEXT,
            gmtOffset                   INTEGER
            );
        """)

        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS key_statistics (
            symbol                      TEXT NOT NULL,
            today                       TEXT,
            lastFiscalYearEnd           TEXT,
            mostRecentQuarter           TEXT,
            trailingEps                 REAL,
            forwardEps                  REAL,
            bookValueps                 REAL,
            enterpriseToRevenue         REAL,      
            enterpriseToEbitda          REAL,
            profitMargins               REAL,
            earningsQuarterlyGrowt      REAL,
            beta                        REAL,
            insidersPercentHeld         REAL,
            institutionsPercentHeld     REAL,
            legalType                   TEXT,
            fundFamily                  TEXT
            );
        """)

        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS target_prices (
            symbol                      TEXT NOT NULL,
            today                       TEXT,
            currentPrice                REAL, 
            targetHighPrice             REAL, 
            targetLowPrice              REAL,  
            targetMeanPrice             REAL, 
            targetMedianPrice           REAL, 
            numberOfAnalystOpinions     INTEGER
            );
        """)

        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS institutional_ownership (
            symbol          TEXT NOT NULL,
            organization    TEXT,
            reportDate      TEXT,
            pctHeld         REAL,
            position        INTEGER,
            value           INTEGER,
            pctChange       REAL
            );
        """)

        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS fund_ownership (
            symbol          TEXT NOT NULL,
            organization    TEXT,
            reportDate      TEXT,
            pctHeld         REAL,
            position        INTEGER,
            value           INTEGER,
            pctChange       REAL
            );
        """)

        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS eps_estimates (
            symbol          TEXT NOT NULL,
            quarter         TEXT,
            epsEstimate     REAL,
            epsActual       REAL
            );
        """)

        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS recommendation_trend (
            symbol      TEXT NOT NULL,
            today       TEXT,
            period      TEXT,
            strongbuy   INTEGER,
            buy         INTEGER,
            hold        INTEGER,
            sell        INTEGER,
            strongsell  INTEGER
            );
        """)

        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS upgrade_downgrade_history (
            symbol      TEXT NOT NULL,
            firm        TEXT NOT NULL,
            date        TEXT,
            toGrade     TEXT,
            fromGrade   TEXT,
            action      TEXT
            );
        """)

        DBInterface.execute(conn, """
        CREATE TABLE IF NOT EXISTS esg_scores (
            symbol                  TEXT NOT NULL,
            date                    TEXT, 
            esgScore                REAL,
            governanceScore         REAL,
            environmentScore        REAL,
            socialScore             REAL,
            esgScorePeers           REAL,
            governanceScorePeers    REAL,
            environmentScorePeers   REAL,
            socialScorePeers        REAL
            );
        """)

    end
    # Return the database connection
    return conn
end


"""
    db_schema(conn, table::String)
"""
function db_schema(conn, table::String)
    # Get the schema DataFrame
    schema_df = describe_table(conn, table)

    # Determine the column names based on the database type
    if conn isa SQLite.DB
        # SQLite: Use 'name' and 'type' columns
        col_name = :name
        col_type = :type
    elseif conn isa DuckDB.DB
        # DuckDB: Use 'column_name' and 'column_type' columns
        col_name = :column_name
        col_type = :column_type
    else
        throw(ArgumentError("Unsupported database type."))
    end

    # Print the schema in a clean format
    println("\nSchema for table: $table")
    println("────────────────────────────────────")
    for row in eachrow(schema_df)
        println("🔹 $(rpad(row[col_name], 20)) : $(row[col_type])")
    end
    println("────────────────────────────────────")

    return schema_df
end

"""
    db_schemas(conn)

Function to print the schema of all tables in the database
"""
function db_schemas(conn)
    # Get the list of all tables in the database
    if conn isa SQLite.DB
        # SQLite: Query sqlite_master for table names
        tables = DBInterface.execute(conn, "SELECT name FROM sqlite_master WHERE type='table'") |> DataFrame
    elseif conn isa DuckDB.DB
        # DuckDB: Query information_schema.tables for table names
        tables = DBInterface.execute(conn, "SELECT table_name AS name FROM information_schema.tables WHERE table_type='BASE TABLE'") |> DataFrame
    else
        throw(ArgumentError("Unsupported database type."))
    end

    # Iterate over all tables and print their schema
    for table in tables.name
        db_schema(conn, table)
    end
end

"""
    describe_table(conn, table_name::String)
"""
function describe_table(conn, table_name::String)
    # Check the database type
    if conn isa SQLite.DB
        # SQLite: Use PRAGMA table_info
        return DBInterface.execute(conn, "PRAGMA table_info($table_name);") |> DataFrame
    elseif conn isa DuckDB.DB
        # DuckDB: Use DESCRIBE
        return DBInterface.execute(conn, "DESCRIBE $table_name;") |> DataFrame
    else
        throw(ArgumentError("Unsupported database type."))
    end
end

function db_info(conn)
    db_path = conn.handle.file  
    if isa(conn, DuckDB.DB)
        data_type = "DuckDB.DB"
    elseif isa(conn, SQLite.DB)
        data_type = "SQLite.DB"
    end
    @info "The $(data_type) database location is: $(db_path)"
    return db_path
end

"""
    table_to_csv(query_result)
"""
function table_to_csv(query_result)
    # Get the column names
    schema = Tables.schema(query_result)
    if schema === nothing
        # SQLite: Extract column names from the query result
        header = join(propertynames(query_result), ",")
    else
        # DuckDB: Use schema.names
        header = join(schema.names, ",")
    end
    # Process rows one by one
    data_rows = []
    for row in Tables.rows(query_result)
        # Convert each row to a CSV string
        push!(data_rows, join(row, ","))
    end
    # Combine header and data rows
    return join([header; data_rows], "\n")
end


"""
    export_table_to_csv(conn, table_name::String, file_path::String)
"""
function export_table_to_csv(conn, table_name::String, file_path::String)
    if conn isa DuckDB.DB
        # DuckDB: Use COPY command
        # DBInterface.execute(conn, "COPY $table_name TO '$file_path' (FORMAT 'csv');")
        DBInterface.execute(conn, "COPY $table_name TO '$file_path' (HEADER, DELIMITER ',');")
    elseif conn isa SQLite.DB
        # SQLite: Manual export using CSV.jl
        query_result = DBInterface.execute(conn, "SELECT * FROM $table_name;")
        df = DataFrame(query_result)
        CSV.write(file_path, df)
    else
        throw(ArgumentError("Unsupported database type."))
    end
end

"""
    export_table_to_xlsx(conn, table_name::String, file_path::String)
"""
function export_table_to_xlsx(conn, table_name::String, file_path::String)
    try
        if conn isa DuckDB.DB
            DBInterface.execute(conn, "COPY $table_name TO '$(file_path)' WITH (FORMAT xlsx, HEADER true, SHEET '$table_name')";)
        elseif conn isa SQLite.DB
            query_result = DBInterface.execute(conn, "SELECT * FROM $table_name")
            csv_data = table_to_csv(query_result) # Convert QueryResult to CSV format
            #sheet_name = table  # Use table name as the sheet name
            csv_to_xlsx(csv_data, table, file_path)
            println("✅ Saved to XLSX: $file_path")
        end
    catch e
        println("An error occurred: ", e)
        throw(e)
    end
end


"""
    export_table_to_parquet(conn, table::String, file_path::String)
"""
function export_table_to_parquet(conn, table::String, file_path::String)
    if conn isa DuckDB.DB
        DBInterface.execute(conn, "COPY $table TO '$file_path' (FORMAT 'parquet')")
    else
        println("❌ Skipping since for the moment saving to the 'parquet' format is only supported for DuckDB databases.")
    end
end