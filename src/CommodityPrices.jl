const COMMODITIES = Dict(
    "Gold"      => "GOLDPMGBD228NLBM",
    "Silver"    => "SLVPRUSD",
    "Platinum"  => "PLATINUM",
    "Palladium" => "PALLADIUM",
    "Aluminum"  => "PALUMUSDM",
    "Copper"    => "PCOPPUSDM",
    "Nickel"    => "PNICKUSDM",
    "Zinc"      => "PZINCUSDM",
    "Lead"      => "PLEADUSDM",
    "Rubber"    => "PRUBBUSDM",
    "Cocoa"     => "PCOCOUSDM",
    "CoffeeArabica" => "PCOFFOTMUSDM",
    "CoffeeRobustas"=> "PCOFFROBUSDM",
    "SugarN11"  => "PSUGAISAUSDM",
    "SugarN16"  => "PSUGAUSAUSDQ",
    "Soybeans"  => "PSOYBUSDM",
    "Wheat"     => "PWHEAMTUSDM",
    "Barley"    => "PBARLUSDM",
    "Corn"      => "PMAIZMTUSDM",
    "Rice"      => "PRICENPQUSDM",
    "Oranges"   => "PORANGUSDM",
    "Bananas"   => "PBANSOPUSDM",
    "Tea"       => "PTEAUSDM",
    "OliveOil"  => "POLVOILUSDM",
    "SunflowerOil"  => "PSUNOUSDM",
    "PalmOil"   => "PPOILUSDM",
    "SoybeansOil"   => "PSOILUSDM",
    "RapeseedOil"   => "PROILUSDM",
    "Cotton"    => "PCOTTINDUSDM",
    "WoolFine"      => "PWOOLFUSDM",
    "WoolCoarse"    => "PWOOLCUSDM",
    "BrentCrude"    => "POILBREUSDM",
    "WTICrude"  => "POILWTIUSDM",
    "DubaiCrude"    => "POILDUBUSDM",
    "NaturalGas"    => "PNGASEUUSDM"
)

const FRED_URL = "https://api.stlouisfed.org/fred/series/observations"

function get_commodity_prices(series_id)
    url = "$FRED_URL?series_id=$series_id&api_key=$FRED_API_KEY&file_type=json"
    response = HTTP.get(url)
    data = JSON3.read(response.body)
    return data["observations"]
end

