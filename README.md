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

Uma vez definido o runtime como Julia, para fazer a instalação da b+iblioteca Caramel.jl no Google Colab,

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
Antes de os pacotes instalados, incluindo o Caramel.jl, poderem ser utilizados numa sessão, teremos de recorrer ao comando: using, como no seguinte exemplo,
```
using Caramel

p = AssetPrice("IBM",Date(2025,02,01), Date(2025,03,03))
println(DataFrame(p))
```
Utilizamos a função AssetPrice para extrair a partir do website Yahoo Finance as cotações das ações da IBM para o período compreendido entre 1 de Fevereiro e 3 de Março de 2025. `DataFrame` organiza os dados numa tabela e println imprime a informação recolhida. A coluna :adjclose apresenta o histórico das cotações de fecho das sessões diárias da New York Stock Exchange, ajustadas por emissão de novas ações, pagamento de dividendos, stock splits e reverse splits ocorridos ao longo do tempo.
















