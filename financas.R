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
    library(myPackages)
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

# Obtendo o preço atual de ativos
atual_tickers <- c("IRDM11.SA", "BTLG11.SA", "VGHF11.SA", "CPTI11.SA", 
                   "RECR11.SA", "RZTR11.SA", "RZAT11.SA", "TGAR11.SA",
                   "BARI11.SA", "MFII11.SA", "RBED11.SA", "CVBI11.SA")

prices <- sapply(atual_tickers, yf_live_prices)
prices <- as.data.frame(t(prices))

prices$price <- as.numeric(prices$price)
prices$last_price <- as.numeric(prices$last_price)
prices$daily_change <- as.numeric(prices$daily_change)

prices$daily_change <- round(prices$daily_change, 4)

# Obtendo dados com o pacote 'BETS': repositório da FGV
library(BETS)

# Obtendo dados de desemprego do Brasil
df_res <- BETSsearch('unemployment', view = F)

glimpse(df_res)

my_id <- 24369

first_date <- '2010-01-01'
last_date <- as.character(Sys.Date())

df_bets <- BETSget(code = my_id,
                   from = first_date,
                   to = last_date,
                   data.frame = TRUE)

ggplot(data = df_bets) +
    geom_smooth(mapping = aes(x = df_bets$date, y = df_bets$value), se = F) +
    labs(title = "Desemprego no Brasil",
         x = "Data", y = "Desemprego")

# Obtendo dados de desemprego de diferentes países
my_id <- 3785:3791

first_date <- '2010-01-01'
last_date <- as.character(Sys.Date())

l_out <- BETSget(code = my_id,
                 from = first_date,
                 to = last_date,
                 data.frame = TRUE)

glimpse(l_out) # gerou uma lista de dataframes

# Criando a função para limpar os dados da lista gerada
clean_bets <- function(df_in, name_in){
    # Setando colunas
    df_in$type <- name_in
    
    # Retornando df
    return(df_in)
}

# Setando nomes dos países
name_in <- c("Germany", "Canada", "United States", "France", "Italy", "Japan", 
             "United Kindom")

# Loop para trocar conteúdo do l_out
for(i.1 in 1:length(l_out)){
    l_out[[i.1]] <- clean_bets(l_out[[i.1]], name_in[i.1])
}

# Juntando todos os df
my_df_long <- do.call(what = dplyr::bind_rows, args = l_out)

# Visualizando a estrutura do df
glimpse(my_df_long)

my_df_long$type <- as.factor(my_df_long$type)

# Visualizando o resultado
ggplot(data = my_df_long) +
    geom_smooth(mapping = aes(x = date, y = value, colour = type), se = F) +
    theme(aspect.ratio = 1) +
    labs(title = "Desemprego de países",
         x = "data", y = "desemprego", colour = "País")
