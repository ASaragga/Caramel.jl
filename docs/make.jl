using Caramelo
using Documenter

DocMeta.setdocmeta!(Caramelo, :DocTestSetup, :(using Caramelo); recursive=true)

makedocs(;
    modules=[Caramelo],
    authors="Antonio Saragga Seabra",
    sitename="Caramelo.jl",
    format=Documenter.HTML(;
        canonical="https://ASaragga.github.io/Caramelo.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/ASaragga/Caramelo.jl",
    devbranch="main",
)
