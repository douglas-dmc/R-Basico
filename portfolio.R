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

# Removendo linhas com 0 na coluna 'Nr de Cotas'
df_portfolio <- df_portfolio[df_portfolio$`nr_cotas_soma` != 0, ]

# Ordenando df_portfolio pelo 'Aporte'
df_portfolio <- df_portfolio[order(df_portfolio$preco_total_soma, 
                                   decreasing = TRUE), ]

# Inserindo a coluna de ativos
df_portfolio <- cbind(df_portfolio, dimnames(df_portfolio)[1])

# Alterando os nomes das colunas
colnames(df_portfolio) <- c("Aporte", "Nr de Cotas", "Preco Medio", "Ativo")

# Criando um gráfico de barras horizontal
library(ggplot2)
library(forcats)

ggplot(df_portfolio, aes(y = Aporte, x = fct_rev(fct_inorder(Ativo)))) +
    geom_bar(stat = "identity", width = .75, show.legend = F, fill = "dodgerblue") + 
    coord_flip() +
    labs(
        x = "Ticker (FII e FI-INFRA)",
        y = "Custo de Aquisição (R$)",
        color = "Aporte (R$)",
        title = "Gráfico de Custo de Aquisição por Ativo"
    )
