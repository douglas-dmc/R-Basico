################################################################################
#                                                                              #
#                        MANIPULAÇÃO DO DF OPERAÇÕES                           #
#                        ÚLTIMA ATUALIZAÇÃO: 13 JAN 2025                       #
#                                                                              #
################################################################################

# Obtendo a relação de ativos
ticker <- operacoes$Ticker

# Definindo os fatores 
factor_ticker <- factor(ticker)

# Obtendo os preços totais dos ativos
preco_total <- operacoes$`Preco Final`

# Obtendo o nr de cotas dos ativos
nr_cotas <- operacoes$`Nr Cotas`

# Somando os preços totais por ativo
preco_total_soma <- tapply(preco_total, factor_ticker, sum)
preco_total_soma <- round(preco_total_soma, 2)

# Somando as cotas por ativo
nr_cotas_soma <- tapply(nr_cotas, factor_ticker, sum)

# Calculando o preço médio por ativo
preco_medio <- round(preco_total_soma/nr_cotas_soma, 2)

# Criando o dataframe
df_portfolio <- data.frame(preco_total_soma, nr_cotas_soma, preco_medio)

# Alterando os nomes das colunas
colnames(df_portfolio) <- c("Aporte", "Nr de Cotas", "Preco Medio")

# Removendo linhas com 0 na coluna 'Nr de Cotas'
df_portfolio <- df_portfolio[df_portfolio$`Nr de Cotas` != 0, ]
