using Caramel
using Documenter

DocMeta.setdocmeta!(Caramel, :DocTestSetup, :(using Caramel); recursive=true)

makedocs(;
    modules=[Caramel],
    authors="Antonio Saragga Seabra",
    sitename="Caramel.jl",
    format=Documenter.HTML(;
        canonical="https://ASaragga.github.io/Caramel.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/ASaragga/Caramel.jl",
    devbranch="main",
)
