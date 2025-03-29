# Caramel
![](GRF01.jpg?raw=true)
  
### Valorização, Aquisição e Reorganização de Empresas e Negócios (ARE)
### Gestão de Riscos Financeiros (GRF)
### Mercados e Produtos Financeiros (MPF)

***


# 1 - Guia de Instalação e Desenvolvimento Julia

## 1.1 - Instalação da Linguagem de Programação Julia

1 Transferir Julia

2 Visite o website oficial da linguagem Julia: https://julialang.org/downloads/

3 Escolha a versão adequada para o seu sistema operativo (Windows, macOS ou Linux)

4 Transfira a versão estável mais recente

## 1.2 - Gestão de Bibliotecas

Biblioteca das disciplinas ARE e GRF: Caramel.jl

### 1.2.1 - Instalação Local da Biblioteca Caramel.jl
Na nossa aplicação Julia local, instalamos a biblioteca Caramel.jl a partir do Repositório no GitHub,
```
using Pkg
Pkg.add(url="https://github.com/ASaragga/Caramel.jl")
```
Esta instalação apenas necessita de ser feita uma vez.

### 1.2.2 - Instalação Online da Biblioteca Caramel.jl no Google Colab
Primeiro, no início de cada sessão, teremos sempre que alterar o runtime do Google Colab de Python para Julia. Pois, por omissão, o runtime do Google Colab  é definido inicialmente como sendo Python.

<p align="center">
  <img src="ColabRuntime.png?raw=true" alt="Colab Runtime" width="700">
</p>

Uma vez definido o runtime como Julia, para fazer a instalação da biblioteca Caramel.jl no Google Colab,

<p align="center">
  <img src="GoogleColab.png?raw=true" alt="Instalação Caramel" width="700">
</p>

Esta instalação tem de ser sempre feita no início de cada sessão, pois o Google Colab não persiste as bibliotecas instaladas entre sessões.

### 1.2.3 - Instalação de Bibliotecas do Repositório Oficial
```
using Pkg
Pkg.add("Distributions")
```
Neste caso estamos a instalar o pacote Distributions que dá acesso a um grande número de distribuições de probabilidade, incluindo a Normal e a T-Student.
A instalação de pactores apenas necessita de ser feita uma vez. 

### 1.2.4 - Usando as Bibliotecas: Comando `using`
Antes de as bibliotecas instalados poderem ser utilizados numa sessão, teremos de recorrer ao comando: *using*, como no seguinte exemplo,
```
using Caramel

p = get_prices(["IBM"],Date(2025,02,01), Date(2025,03,03))
```
Utilizamos a função ```get_prices``` para extrair a partir do website Yahoo Finance as cotações das ações da IBM para o período compreendido entre 1 de Fevereiro e 3 de Março de 2025.
```
19×8 DataFrame
 Row │ ticker  date        open     high     low      close    adjclose  vol       
     │ String  Date        Float64  Float64  Float64  Float64  Float64   Float64   
─────┼─────────────────────────────────────────────────────────────────────────────
   1 │ IBM     2025-02-03  250.73   260.326  250.173   260.73   259.004  8.35285e6
   2 │ IBM     2025-02-04  258.279  263.495  256.412   264.46   262.71   6.03748e6
   3 │ IBM     2025-02-05  263.951  263.961  259.451   263.3    261.557  6.1243e6
   4 │ IBM     2025-02-06  261.24   261.637  251.057   253.44   251.763  6.08774e6
   ⋮     ⋮         ⋮          ⋮        ⋮        ⋮        ⋮        ⋮          ⋮
  16 │ IBM     2025-02-25  261.08   263.48   256.77    257.75   257.75   6.2922e6
  17 │ IBM     2025-02-26  258.1    258.33   254.41    255.84   255.84   3.4601e6
  18 │ IBM     2025-02-27  255.22   257.63   253.05    253.23   253.23   3.4022e6
  19 │ IBM     2025-02-28  250.86   252.81   246.54    252.44   252.44   7.9888e6
                                                                    11 rows omitted
```
A coluna :adjclose apresenta o histórico das cotações de fecho das sessões diárias da New York Stock Exchange, ajustadas por emissão de novas ações, pagamento de dividendos, stock splits e reverse splits ocorridos ao longo do tempo. 

# 2 - Obter Cotações
Podemos também definir um vector de n símbolos para os quais pretendemos obter cotações
```
p = get_prices(["IBM", "AAPL"],Date(2025,02,01), Date(2025,03,03))
```
```
38×8 DataFrame
 Row │ ticker  date        open     high     low      close    adjclose  vol       
     │ String  Date        Float64  Float64  Float64  Float64  Float64   Float64   
─────┼─────────────────────────────────────────────────────────────────────────────
   1 │ IBM     2025-02-03  250.73   260.326  250.173   260.73   259.004  8.35285e6
   2 │ IBM     2025-02-04  258.279  263.495  256.412   264.46   262.71   6.03748e6
   3 │ IBM     2025-02-05  263.951  263.961  259.451   263.3    261.557  6.1243e6
   4 │ IBM     2025-02-06  261.24   261.637  251.057   253.44   251.763  6.08774e6
   ⋮     ⋮         ⋮          ⋮        ⋮        ⋮        ⋮        ⋮          ⋮
  35 │ AAPL    2025-02-25  248.0    250.0    244.91    247.04   247.04   4.80133e7
  36 │ AAPL    2025-02-26  244.33   244.98   239.13    240.36   240.36   4.44336e7
  37 │ AAPL    2025-02-27  239.41   242.46   237.06    237.3    237.3    4.11536e7
  38 │ AAPL    2025-02-28  236.95   242.09   230.2     241.84   241.84   5.68334e7
                                                                    30 rows omitted
```

# 3 - Obter Retornos
 
Para obtermos retornos logarítmicos $log(P_t/P_{t-1})$ ou simples $(P_t-P_{t-1})/P_{t-1}$, podemos fazer
```
r = get_returns(["IBM"],Date(2025,02,01), Date(2025,03,03), return_type = "log")
``` 
ou 
```
r = get_returns(["IBM"],Date(2025,02,01), Date(2025,03,03))
```  
sendo assumido por omissão que ```return_type = "log"```.  Em Julia, os logarítmos base (e) são denotados por log e os logarítmos base (10) por log10. Para retornos simples teremos,
```
r = get_returns(["IBM"],Date(2025,02,01), Date(2025,03,03), return_type = "simple")
``` 
```
18×2 DataFrame
 Row │ date        IBM         
     │ Date        Float64?    
─────┼─────────────────────────
   1 │ 2025-02-04   0.0143059
   2 │ 2025-02-05  -0.00438638
   3 │ 2025-02-06  -0.0374477
   4 │ 2025-02-07  -0.00434031
   ⋮        ⋮            ⋮
  15 │ 2025-02-25  -0.015733
  16 │ 2025-02-26  -0.0074103
  17 │ 2025-02-27  -0.0102017
  18 │ 2025-02-28  -0.00311967
                10 rows omitted
```
Também com os retornos podemos definir um vector de n símbolos, como no exemplo seguinte, queonde agora calculamos os log-retornos para as ações da IBM e Apple
```
r = get_returns(["IBM", "AAPL"],Date(2025,02,01), Date(2025,03,03))
```
```
18×3 DataFrame
 Row │ date        AAPL          IBM         
     │ Date        Float64?      Float64?    
─────┼───────────────────────────────────────
   1 │ 2025-02-04   0.0207902     0.0142045
   2 │ 2025-02-05  -0.00141852   -0.00439602
   3 │ 2025-02-06   0.00322103   -0.0381669
   4 │ 2025-02-07  -0.0242607    -0.00434975
   ⋮       ⋮            ⋮             ⋮
  15 │ 2025-02-25  -0.000242898  -0.0158581
  16 │ 2025-02-26  -0.0274124    -0.00743789
  17 │ 2025-02-27  -0.0128126    -0.0102541
  18 │ 2025-02-28   0.0189512    -0.00312454
                              10 rows omitted
```
Os retornos aparecem em colunas cujos nomes são o respectivo símbolo. Facilmente extraimos os vetores de retornos correspondentes aos ativos pretendidos. Neste caso com as ações da IBM fazemos,
```
rIBM = r[:,:IBM]
```
```
18-element Vector{Union{Missing, Float64}}:
  0.01420453418714144
 -0.004396023934239164
 -0.03816687340275505
 -0.004349754298275607
 -0.005600601404099054
  0.021549706518745562
  ⋮
 -0.012390334637548853
  0.001490338008958795
 -0.015858055872357914
 -0.007437888125486338
 -0.01025408497970419
 -0.003124543404606346
```
```
rIBM = r[1:3,:IBM]
```
```
3-element Vector{Union{Missing, Float64}}:
  0.01420453418714144
 -0.004396023934239164
 -0.03816687340275505
```
# 4 - Calcular Volatilidades
Finalmente, computamos a volatilidade diária das cotações da IBM neste período, usando a biblioteca ```Statistics```
```
using Statistics

vol = std(rIBM)
println("Volatilidade IBM = ", vol)
```
```
Volatilidade IBM = 0.013417809152972431
```




























