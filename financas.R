################################################################################
#                                                                              #
#                         ESTUDO DE FINANÇAS NO R                              #
#                         ÚLTIMA ATUALIZAÇÃO: 24 JAN 2025                      #
#                                                                              #
################################################################################

# Carregando pacotes
myPackages <- c("yfR", "Quandl", "BETS", "rbcb", "GetDFPData", 
                "GetHFData", "GetTDData", "dplyr")

if (!require(myPackages)){
    install.packages(myPackages)
}

# Obtendo dados de ativos com 'yfR'
library(yfR)  

# Definindo ativos
tickers <- c("PETR4.SA", "BBDC4.SA", "GOAU4.SA", "GGBR4.SA")

# Setando parâmetros
f_date <- Sys.Date() - 60
l_date <- Sys.Date()
bench <- '^BVSP'
thresh_bad <- 0.95
cache <- yf_cachefolder_get()

# Obtendo os dados financeiros
l_out <- yf_get(tickers = tickers,
                first_date = f_date,
                last_date = l_date,
                bench_ticker = bench,
                thresh_bad_data = thresh_bad,
                cache_folder = cache)

# Visualizando a estrutura dos dados
glimpse(l_out)

# Obtendo a composição do índice bovespa
df_ibov <- yf_index_composition(mkt_index = 'IBOV',
                                do_cache = T,
                                cache_folder = yf_cachefolder_get())

# Obtendo os preços de um ativo
atual_tickers <- c("IRDM11.SA", "BTLG11.SA", "VGHF11.SA", "CPTI11.SA")

for(i in 1:length(atual_tickers)){
    atual_price <- yf_live_prices(atual_tickers[i])
    
}
