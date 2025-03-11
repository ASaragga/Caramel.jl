# S&P 500 components, plus
# S&P 500 Index: "^GSPC" 
# Russel 2000: "^RUT" 
# Russell 2000 Growth: "^RUO" 
# Russell 2000 Value: "^RUJ"

global SP500 = ["^GSPC", "^RUT", "^RUO", "^RUJ", "MMM", "AOS", "ABT", "ABBV", "ACN", "ADBE", "AMD", "AES", "AFL", "A", "APD", "ABNB", "AKAM", "ALB", "ARE", "ALGN", "ALLE", "LNT", "ALL", "GOOGL", "GOOG", "MO", "AMZN", "AMCR", "AMTM", "AEE", "AEP", "AXP", "AIG", "AMT", "AWK", "AMP", "AME", "AMGN", "APH", "ADI", "ANSS", "AON", "APA", "AAPL", "AMAT", "APTV", "ACGL", "ADM", "ANET", "AJG", "AIZ", "T", "ATO", "ADSK", "ADP", "AZO", "AVB", "AVY", "AXON", "BKR", "BALL", "BAC", "BAX", "BDX", "BRK-B", "BBY", "TECH", "BIIB", "BLK", "BX", "BK", "BA", "BKNG", "BWA", "BSX", "BMY", "AVGO", "BR", "BRO", "BF-B", "BLDR", "BG", "BXP", "CHRW", "CDNS", "CZR", "CPT", "CPB", "COF", "CAH", "KMX", "CCL", "CARR", "CTLT", "CAT", "CBOE", "CBRE", "CDW", "CE", "COR", "CNC", "CNP", "CF", "CRL", "SCHW", "CHTR", "CVX", "CMG", "CB", "CHD", "CI", "CINF", "CTAS", "CSCO", "C", "CFG", "CLX", "CME", "CMS", "KO", "CTSH", "CL", "CMCSA", "CAG", "COP", "ED", "STZ", "CEG", "COO", "CPRT", "GLW", "CPAY", "CTVA", "CSGP", "COST", "CTRA", "CRWD", "CCI", "CSX", "CMI", "CVS", "DHR", "DRI", "DVA", "DAY", "DECK", "DE", "DELL", "DAL", "DVN", "DXCM", "FANG", "DLR", "DFS", "DG", "DLTR", "D", "DPZ", "DOV", "DOW", "DHI", "DTE", "DUK", "DD", "EMN", "ETN", "EBAY", "ECL", "EIX", "EW", "EA", "ELV", "EMR", "ENPH", "ETR", "EOG", "EPAM", "EQT", "EFX", "EQIX", "EQR", "ERIE", "ESS", "EL", "EG", "EVRG", "ES", "EXC", "EXPE", "EXPD", "EXR", "XOM", "FFIV", "FDS", "FICO", "FAST", "FRT", "FDX", "FIS", "FITB", "FSLR", "FE", "FI", "FMC", "F", "FTNT", "FTV", "FOXA", "FOX", "BEN", "FCX", "GRMN", "IT", "GE", "GEHC", "GEV", "GEN", "GNRC", "GD", "GIS", "GM", "GPC", "GILD", "GPN", "GL", "GDDY", "GS", "HAL", "HIG", "HAS", "HCA", "DOC", "HSIC", "HSY", "HES", "HPE", "HLT", "HOLX", "HD", "HON", "HRL", "HST", "HWM", "HPQ", "HUBB", "HUM", "HBAN", "HII", "IBM", "IEX", "IDXX", "ITW", "INCY", "IR", "PODD", "INTC", "ICE", "IFF", "IP", "IPG", "INTU", "ISRG", "IVZ", "INVH", "IQV", "IRM", "JBHT", "JBL", "JKHY", "J", "JNJ", "JCI", "JPM", "JNPR", "K", "KVUE", "KDP", "KEY", "KEYS", "KMB", "KIM", "KMI", "KKR", "KLAC", "KHC", "KR", "LHX", "LH", "LRCX", "LW", "LVS", "LDOS", "LEN", "LLY", "LIN", "LYV", "LKQ", "LMT", "L", "LOW", "LULU", "LYB", "MTB", "MPC", "MKTX", "MAR", "MMC", "MLM", "MAS", "MA", "MTCH", "MKC", "MCD", "MCK", "MDT", "MRK", "META", "MET", "MTD", "MGM", "MCHP", "MU", "MSFT", "MAA", "MRNA", "MHK", "MOH", "TAP", "MDLZ", "MPWR", "MNST", "MCO", "MS", "MOS", "MSI", "MSCI", "NDAQ", "NTAP", "NFLX", "NEM", "NWSA", "NWS", "NEE", "NKE", "NI", "NDSN", "NSC", "NTRS", "NOC", "NCLH", "NRG", "NUE", "NVDA", "NVR", "NXPI", "ORLY", "OXY", "ODFL", "OMC", "ON", "OKE", "ORCL", "OTIS", "PCAR", "PKG", "PLTR", "PANW", "PARA", "PH", "PAYX", "PAYC", "PYPL", "PNR", "PEP", "PFE", "PCG", "PM", "PSX", "PNW", "PNC", "POOL", "PPG", "PPL", "PFG", "PG", "PGR", "PLD", "PRU", "PEG", "PTC", "PSA", "PHM", "QRVO", "PWR", "QCOM", "DGX", "RL", "RJF", "RTX", "O", "REG", "REGN", "RF", "RSG", "RMD", "RVTY", "ROK", "ROL", "ROP", "ROST", "RCL", "SPGI", "CRM", "SBAC", "SLB", "STX", "SRE", "NOW", "SHW", "SPG", "SWKS", "SJM", "SW", "SNA", "SOLV", "SO", "LUV", "SWK", "SBUX", "STT", "STLD", "STE", "SYK", "SMCI", "SYF", "SNPS", "SYY", "TMUS", "TROW", "TTWO", "TPR", "TRGP", "TGT", "TEL", "TDY", "TFX", "TER", "TSLA", "TXN", "TPL", "TXT", "TMO", "TJX", "TSCO", "TT", "TDG", "TRV", "TRMB", "TFC", "TYL", "TSN", "USB", "UBER", "UDR", "ULTA", "UNP", "UAL", "UPS", "URI", "UNH", "UHS", "VLO", "VTR", "VLTO", "VRSN", "VRSK", "VZ", "VRTX", "VTRS", "VICI", "V", "VST", "VMC", "WRB", "GWW", "WAB", "WBA", "WMT", "DIS", "WBD", "WM", "WAT", "WEC", "WFC", "WELL", "WST", "WDC", "WY", "WMB", "WTW", "WYNN", "XEL", "XYL", "YUM", "ZBRA", "ZBH", "ZTS"]

# S&P 5000 Index: "^GSPC"
# DJ30 Index: "^DJI"
# Dow Jones Industrial Average 30 (DJ30) components
global DJ30 = ["^GSPC", "^DJI", "AAPL", "AMGN", "AXP", "BA", "CAT", "CRM", "CSCO", "CVX", "DD", "DIS", "GS", "HD", "HON", "IBM", "INTC", "JNJ", "JPM", "KO", "MCD", "MMM", "MRK", "MSFT", "NKE", "PG", "TRV", "UNH", "V", "VZ", "WBA", "WMT"]

# UK FTSE 100: "^FTSE"
# UK FTSE 100 components
global FTSE100 = ["^FTSE", "III.L", "ADM.L", "AAL.L", "ANTO.L", "AHT.L", "ABF.L", "AZN.L", "AUTO.L", "AVST.L", "AVV.L", "AV.L", "BME.L", "BA.L", "BARC.L", "BDEV.L", "BKG.L", "BHP.L", "BP.L", "BATS.L", "BLND.L", "BT-A.L", "BNZL.L", "BRBY.L", "CCH.L", "CPG.L", "CRH.L", "CRDA.L", "DCC.L", "DGE.L", "ENT.L", "EVR.L", "EXPN.L", "FERG.L", "FLTR.L", "FRES.L", "GSK.L", "GLEN.L", "HLMA.L", "HL.L", "HIK.L", "HSBA.L", "IHG.L", "IMB.L", "INF.L", "ICP.L", "IAG.L", "ITRK.L", "JD.L", "JMAT.L", "JET.L", "KGF.L", "LAND.L", "LGEN.L", "LLOY.L", "LSEG.L", "MNG.L", "MRO.L", "MNDI.L", "NG.L", "NWG.L", "NXT.L", "OCDO.L", "PSON.L", "PSH.L", "PSN.L", "PHNX.L", "POLY.L", "PRU.L", "RB.L", "REL.L", "RSW.L", "RTO.L", "RMV.L", "RIO.L", "RR.L", "RDSA.L", "RSA.L", "SGE.L", "SBRY.L", "SDR.L", "SMT.L", "SGRO.L", "SVT.L", "SMDS.L", "SMIN.L", "SN.L", "SKG.L", "SPX.L", "SSE.L", "STAN.L", "SLA.L", "STJ.L", "TW.L", "TSCO.L", "ULVR.L", "UU.L", "VOD.L", "WEIR.L", "WTB.L", "WPP.L", "^FTSE"]

# Germany DAX 40 Index: "^GDAXI"
# Germany DAX 40 components
global DAX40 = ["^GDAXI","ADS.DE","AIR.PA","ALV.DE","BAS.DE","BAYN.DE","BEI.DE","BMW.DE","BNR.DE","CBK.DE","CON.DE","1COV.DE","DTG.DE","DBK.DE","DB1.DE","DHL.DE","DTE.DE","EOAN.DE","FRE.DE","HNR1.DE","HEI.DE","HEN3.DE","IFX.DE","MBG.DE","MRK.DE","MTX.DE","MUV2.DE","P911.DE","PAH3.DE","QIA.DE","RHM.DE","RWE.DE","SAP.DE","SRT3.DE","SIE.DE","ENR.DE","SHL.DE","SY1.DE","VOW3.DE","VNA.DE","ZAL.DE"]

# France CAC 40 Index: "^FCHI"
# France CAC 40 components
global CAC40 = ["^FCHI", "AI.PA", "AIR.PA", "ALO.PA", "MT.AS", "ATO.PA", "CS.PA", "BNP.PA", "EN.PA", "CAP.PA", "CA.PA", "ACA.PA", "BN.PA", "DSY.PA", "ENGI.PA", "EL.PA", "RMS.PA", "KER.PA", "OR.PA", "LR.PA", "MC.PA", "ML.PA", "ORA.PA", "RI.PA", "PUB.PA", "RNO.PA", "SAF.PA", "SGO.PA", "SAN.PA", "SU.PA", "GLE.PA", "STLA.PA", "STM.PA", "TEP.PA", "HO.PA", "FP.PA", "URW.AS", "VIE.PA", "DG.PA", "VIV.PA", "WLN.PA"]

# Italy FTSE MIB Index: "FTSEMIB.MI"
# Italy FTSE MIB components
global FTSEMIB = ["FTSEMIB.MI", "A2A.MI", "AMP.MI", "ATL.MI", "AZM.MI", "BGN.MI", "BAMI.MI", "BPE.MI", "BRE.MI", "BZU.MI", "CPR.MI", "CNHI.MI", "DIA.MI", "ENEL.MI", "ENI.MI", "EXO.MI", "RACE.MI", "FBK.MI", "G.MI", "ISP.MI", "IG.MI", "JUVE.MI", "LDO.MI", "MB.MI", "MONC.MI", "PIRC.MI", "PST.MI", "PRY.MI", "REC.MI", "SPM.MI", "SFER.MI", "SRG.MI", "STLA.MI", "STM.MI", "TIT.MI", "TEN.MI", "TRN.MI", "UBI.MI", "UCG.MI", "UNI.MI", "US.MI"]

# Switzerland Market Index (SMI): ^SSMI
# Switzerland Market Index (SMI) components
global SMI = ["^SSMI", "NESN.SW", "NOVN.SW", "ROG.SW", "ZURN.SW", "UBSG.SW", "ABBN.SW", "CFR.SW", "LONN.SW", "SIKA.SW", "ALC.SW", "GIVN.SW", "LHN.SW", "SCMN.SW", "CSGN.SW", "PGHN.SW", "SREN.SW", "GEBN.SW", "SGSN.SW", "SLHN.SW", "UHR.SW"]

# Portugal PSI Index: PSI20.LS
# Portugal PSI symbol components
global PSI = ["PSI20.LS", "ALTR.LS", "BCP.LS", "COR.LS", "CTT.LS", "EDP.LS", "EDPR.LS", "GALP.LS", "IBS.LS", "JMT.LS", "EGL.LS", "NBA.LS", "NOS.LS", "NVG.LS", "PHR.LS", "RAM.LS", "RENE.LS", "SEM.LS", "SON.LS", "PSI20.LS"]

# EC EUROSTOXX 50 Index
# EC EUROSTOXX 50 components
global EUROSTOXX50 = ["^STOXX50E", "ADS.DE", "AD.AS", "AI.PA", "AIR.PA", "ALV.DE", "ABI.BR", "ASML.AS", "AMS.MC", "CS.PA", "BBVA.MC", "SAN.MC", "BAS.DE", "BAYN.DE", "BMW.DE", "BNP.PA", "CRG.IR", "SGO.PA", "DAI.DE", "DPW.DE", "DTE.DE", "ENEL.MI", "ENGI.PA", "ENI.MI", "EOAN.DE", "EL.PA", "FRE.DE", "BN.PA", "IBE.MC", "ITX.MC", "INGA.AS", "ISP.MI", "LIN.DE", "OR.PA", "MC.PA", "MUV2.DE", "NOKIA.HE", "ORA.PA", "PHIA.AS", "SAF.PA", "SAN.PA", "SAP.DE", "SU.PA", "SIE.DE", "GLE.PA", "TEF.MC", "FP.PA", "URW.AS", "UNA.AS", "DG.PA", "VIV.PA", "VOW.DE"]

# Japan Nikkei 225 Index: "^N225"
# Japan Nikkei 225 components
global NIKKEI225 = ["^N225", "6857.T", "8267.T", "5201.T", "2802.T", "6770.T", "6113.T", "9202.T", "8304.T", "2502.T", "3407.T", "4503.T", "7832.T", "5108.T", "7751.T", "6952.T", "9022.T", "9502.T", "4519.T", "7762.T", "1721.T", "7186.T", "8253.T", "4751.T", "7912.T", "8750.T", "4568.T", "6367.T", "1925.T", "8601.T", "2432.T", "4061.T", "6902.T", "4324.T", "4631.T", "5714.T", "9020.T", "6361.T", "4523.T", "5020.T", "6954.T", "9983.T", "6504.T", "4901.T", "5803.T", "6702.T", "8354.T", "5801.T", "6674.T", "1808.T", "7205.T", "6305.T", "7004.T", "6501.T", "7267.T", "5019.T", "7013.T", "1605.T", "3099.T", "7202.T", "8001.T", "3086.T", "8697.T", "6178.T", "2914.T", "5411.T", "1963.T", "6473.T", "1812.T", "4452.T", "7012.T", "9107.T", "9433.T", "9008.T", "9009.T", "2801.T", "2503.T", "5406.T", "6301.T", "9766.T", "4902.T", "6326.T", "3405.T", "6971.T", "4151.T", "2413.T", "8002.T", "1333.T", "8252.T", "8628.T", "7261.T", "2269.T", "6479.T", "4188.T", "8058.T", "6503.T", "8802.T", "7011.T", "9301.T", "5711.T", "7211.T", "8306.T", "8031.T", "4183.T", "7003.T", "8801.T", "5706.T", "9104.T", "8411.T", "8725.T", "6701.T", "3659.T", "5333.T", "2282.T", "2871.T", "7731.T", "5214.T", "9062.T", "5703.T", "3863.T", "5202.T", "5401.T", "1332.T", "9432.T", "9101.T", "4021.T", "7201.T", "2002.T", "3105.T", "6988.T", "8604.T", "6471.T", "6472.T", "9613.T", "1802.T", "9007.T", "3861.T", "6703.T", "6103.T", "7733.T", "6645.T", "9532.T", "4578.T", "5541.T", "6752.T", "4755.T", "6098.T", "8308.T", "7752.T", "2501.T", "7735.T", "9735.T", "6724.T", "1928.T", "3382.T", "6753.T", "1803.T", "4063.T", "8303.T", "4507.T", "4911.T", "4004.T", "9412.T", "9434.T", "9984.T", "2768.T", "8630.T", "6758.T", "7270.T", "3436.T", "4005.T", "8053.T", "4506.T", "5802.T", "6302.T", "5713.T", "8316.T", "8309.T", "5232.T", "8830.T", "7269.T", "8795.T", "5233.T", "1801.T", "6976.T", "2531.T", "8233.T", "4502.T", "6762.T", "3401.T", "4543.T", "8331.T", "5631.T", "9503.T", "8355.T", "5101.T", "9001.T", "9602.T", "5707.T", "5301.T", "8766.T", "4043.T", "9501.T", "8035.T", "9531.T", "8804.T", "9005.T", "3289.T", "7911.T", "3402.T", "4042.T", "5332.T", "5901.T", "3101.T", "7203.T", "8015.T", "4704.T", "4208.T", "3103.T", "9021.T", "7951.T", "7272.T", "9064.T", "6506.T", "6841.T", "4689.T"]

# Hong-Kong HANG SENG Index
# Hong-Kong HANG SENG components
global HKSE = ["^HSI", "0005.HK", "0011.HK", "0388.HK", "0939.HK", "1299.HK", "1398.HK", "2318.HK", "2388.HK", "2628.HK", "3328.HK", "3988.HK", "0002.HK", "0003.HK", "0006.HK", "1038.HK", "0012.HK", "0016.HK", "0017.HK", "0101.HK", "0688.HK", "0823.HK", "0960.HK", "1109.HK", "1113.HK", "1997.HK", "2007.HK", "0001.HK", "0027.HK", "0066.HK", "0175.HK", "0241.HK", "0267.HK", "0288.HK", "0386.HK", "0669.HK", "0700.HK", "0762.HK", "0857.HK", "0883.HK", "0941.HK", "1044.HK", "1093.HK", "1177.HK", "1810.HK", "1876.HK", "1928.HK", "2018.HK", "2020.HK", "2269.HK", "2313.HK", "2319.HK", "2382.HK", "3690.HK", "6862.HK", "9988.HK"]

# Australia S&P/ASX 50 Index
# Australia S&P/ASX 50 components
global ASX50 = ["^AFLI", "A2M.AX", "AGL.AX", "AMC.AX", "ANZ.AX", "APA.AX", "ALD.AX", "ALL.AX", "ASX.AX", "AZJ.AX", "BHP.AX", "BXB.AX", "COH.AX", "COL.AX", "CBA.AX", "CPU.AX", "CSL.AX", "DXS.AX", "FMG.AX", "GMG.AX", "GPT.AX", "IAG.AX", "JHX.AX", "LLC.AX", "MQG.AX", "MPL.AX", "MGR.AX", "NAB.AX", "NCM.AX", "OSH.AX", "ORI.AX", "ORG.AX", "QAN.AX", "QBE.AX", "RHC.AX", "RIO.AX", "STO.AX", "SCG.AX", "SHL.AX", "S32.AX", "SGP.AX", "SUN.AX", "SYD.AX", "TLS.AX", "TCL.AX", "TWE.AX", "VCX.AX", "WES.AX", "WBC.AX", "WPL.AX", "WOW.AX"]

# NASDAQ Composite Index: "^IXIC"
# NASDAQ 100 Index: "^NDX" 
# NASDAQ 100 Equal Weighted "^NDXE"
# NASDAQ Global Market Composite: "^NQGM"
global NASDAQ = ["^IXIC", "^NDX", "^NDXE", "^NQGM"] 

# Implied Volatility Indices 
global VOL = ["^VIX", "^VVIX"] 

# Financial Modelling Prep (FMP)
# Free Tier
global FMP = ["AAPL", "TSLA", "AMZN", "MSFT", "NVDA", "GOOGL", "META", "NFLX", "JPM", "V", "BAC", "AMD", "PYPL", "DIS", "T", "PFE", "COST", "INTC", "KO", "TGT", "NKE", "SPY", "BA", "BABA", "XOM", "WMT", "GE","CSCO", "VZ", "JNJ", "CVX", "PLTR", "SQ", "SHOP", "SBUX", "SOFI", "HOOD", "RBLX", "SNAP", "AMD", "UBER", "FDX", "ABBV", "ETSY", "MRNA", "LMT", "GM", "F", "RIVN", "LCID", "CCL", "DAL", "UAL", "AAL", "TSM", "SONY", "ET", "NOK", "MRO", "COIN", "RIVN", "SIRI", "SOFI", "RIOT", "CPRX", "PYPL", "TGT", "VWO", "SPYG", "NOK", "ROKU", "HOOD", "VIAC", "ATVI", "BIDU", "DOCU", "ZM", "PINS", "TLRY", "WBA", "MGM", "NFLX", "NIO", "C", "GS", "WFC", "ADBE", "PEP", "UNH", "CARR", "FUBO", "HCA", "TWTR", "BILI", "RKT"]

MARKETS = ["AMEX", "NASDAQ", "NYSE", "USALL", "JPX", "SZSE", "BSE", "TSX", "ASX", "EURONEXT"]
"""
    symbols(market::String)

Fetch all the symbols from a given `market`.

# Arguments
- `market::String`: The market to fetch the symbols from.
Currently supported markets are:
  - `NYSE`
  - `NASDAQ`
  - `AMEX`
  - `EURONEXT` 
  - `JPX`
  - `SZSE` 
  - `BSE` 
  - `TSX`
  - `ASX`


# Returns
- `Vector{String}`: A vector of strings containing the symbols.

# Example
```julia
julia> symbols("NYSE")
3127-element Vector{String}:
 "A"
 "AA"
 "AAC"
 "AAN"
 ⋮
 "ZTR"
 "ZTS"
 "ZUO"
 "ZYME"
```
"""
function symbols(market::String)
  uppercase(market) in MARKETS || throw(ArgumentError("Invalid market. Supported markets are $(MARKETS)"))
  if uppercase(market) != "EURONEXT" && uppercase(market) != "USALL"
    url = "https://dumbstockapi.com/stock?format=tickers-only&exchange=$market"
    response = HTTP.request("GET", url)
    Symbols_string = String(response.body)
    splitted = split(Symbols_string, ",")
    pured = replace.(splitted, r"\"" => "")
    f_idx, l_idx = firstindex(pured), lastindex(pured)
    pured[f_idx] = replace(pured[f_idx], r"\[" => "")
    pured[l_idx] = replace(pured[l_idx], r"\]" => "")
    return pured
  elseif uppercase(market) == "EURONEXT"
    euronext_path = joinpath(data_path, "Euronext.xlsx")
    df = DataFrame(XLSX.readtable(euronext_path,"Symbols"))
    #df = CSV.read(euronext_path,DataFrame)
    subset!(df, :Exchange => ByRow(x -> x != "EuroTLX"))
    subset!(df, :Exchange => ByRow(x -> x != "Trading After Hours"))
    select!(df, :Symbol, :Name, :Exchange, :Currency, :ISIN)
    return df
  else uppercase(market) == "USALL"
    usall_path = joinpath(data_path, "USALL.xlsx")
    df = DataFrame(XLSX.readtable(usall_path,"Symbols"))
    return df
  end
end

