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

# Obtendo dados com o pacote 'rbcb': repositório do BCB

# Carregando o pacote
library(rbcb)

# Obtendo dados de inadimplência de crédito do sistema financeiro brasileiro
id_series <- c(perc_default = 21082) # definindo o nome da coluna: perc_default
first_date <- '2010-01-01'
last_date <- '2025-01-24'

# Obtendo as séries temporais do BCB
df_cred <- get_series(id_series, 
                      start_date = first_date, 
                      end_date = last_date)

# Visualizando a estrutura dos dados
glimpse(df_cred)

# Visualizando o gráfico de inadimplência de crédito
ggplot(data = df_cred) +
    geom_smooth(mapping = aes(x = date, y = perc_default), se = F) +
    labs(title = "Inadimplência total no Sistema Financeiro Brasileiro",
         x = "data",
         y = "default (%)")

# Obtendo os dados de inadimplência para pessoas físicas e empresas
id_series <- c(people = 21083, companies = 21084)

# Obtendo as series do BCB
l_out <- get_series(id_series, first_date, last_date)

# Visualizando a estrutura dos dados
glimpse(l_out)

# Função para limpar os dados
clean_rbcb <- function(df_in){
    df_in$type <- names(df_in)[2]
    names(df_in) <- c("date", "value", "type")
    
    return(df_in)
}

# Chamando clean_rbcb para cada elemento de l_out
l_out <- lapply(X = l_out, FUN = clean_rbcb)

# Juntando os dataframes em l_out
df_cred <- do.call(rbind, l_out)

# Checando a estrutura dos dados
glimpse(df_cred)

# Visualizando o gráfico das inadimplências
ggplot(data = df_cred, aes(x = date, y = value, colour = type)) +
    geom_line() +
    labs(title = "Inadimplência de Pessoas e Companhias (2010-2025)",
         subtitle = "Percentual de Default de Créditos",
         caption = "Dados obtidos do BC do Brasil",
         x = "year",
         y = "default (%)",
         colour = "") +
    scale_x_date(date_breaks = "1 year", date_labels = "%Y")

# Obtendo dados da cotação do dólar
df_dolar <- get_currency("USD", first_date, last_date)

# Viauslizando a estrutura dos dados
glimpse(df_dolar)

# Visualizando o gráfico da cotação do dólar
ggplot(data = df_dolar) +
    geom_smooth(mapping = aes(x = date, y = bid), se = F) +
    labs(title = "Preço do Dólar",
         x = "data",
         y = "cotação do dólar (R$)")

# Obtendo dados de companhias com o pacote 'GetDFPData': repositório da B3 e CVM

# Carregando pacote
library(GetDFPData2)

# Pesquisando por empresa
df_search <- search_company("Petrobras", cache_folder = "gdfpd2_cache")

# Obtendo informações sobre empresa
df_cia <- get_info_companies(cache_folder = "gdfp2_cache")

# Obtendo o DFP de uma empresa
df_dfp <- get_dfp_data(9512, 
                       first_year = '2010',
                       last_year = lubridate::year(Sys.Date()),
                       type_docs = 'DRE',
                       type_format = 'con',
                       clean_data = T,
                       do_shiny_progress = F)

# Exportando dados DFP para um artquivo excel
export_xlsx(df_dfp, f_xlsx = "dfp.xlsx")

# Verificando a existência do arquivo
file.exists("dfp.xlsx")

# Obtendo dados de alta frequência (HF) com o pacote 'GetHFData' do GitHub

# Carregando pacote
library(GetHFData)

# Setando os tickers e tipo de mercado
my_ticker <- c("PETR4", "BBDC4")
my_type_market <- "equity"

# Setando a data
last_date <- "2024-01-24"

# Obtendo os dados
my_df <- ghfd_get_HF_data(my.assets = my_ticker, 
                          type.market = my_type_market,
                          first.date = last_date,
                          last.date = last_date,
                          first.time = '10:00:00',
                          last.time = '16:00:00',
                          type.output = "agg",
                          agg.diff = "5 min")

# Checando a estrutura dos dados
glimpse(my_df)