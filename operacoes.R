################################################################################
#                                                                              #
#                   MANIPULAÇÃO DE DADOS DO ARQUIVO 'ativos.xlsx'              #
#                   GERAÇÃO DO DF OPERACOES_TEMP                               #
#                   ÚLTIMA ATUALIZAÇÃO: 14 JAN 2025                            #
#                                                                              #
################################################################################

# Carregando o pacote para leitura de arquivos do excel
library(readxl)

# Lendo a planilha e gerando o df 'operacoes'
operacoes <- read_xlsx(
            "ativos.xlsx",
            # define a planilha
            sheet = 5,
            # define a 1ª linha como título
            col_names = TRUE,
            progress = readxl_progress(),
            skip = 0,
            col_types = c(
                "text",
                "text",
                "numeric",
                "date",
                "numeric",
                "numeric",
                "numeric",
                "numeric",
                "numeric",
                "numeric",
                "logical"
            )
)

# Criando o df operacoes_temp
operacoes_temp <- operacoes

# Somando todas as taxas e despesas
operacoes_temp <- within(operacoes_temp, Despesas <- `Taxa da B3` + `Taxa da CBLC` + 
           `Outras Despesas`)

# removendo as colunas: Taxa da B3, Taxa da CBLC e Outras Despesas
operacoes_temp$`Taxa da B3` <- NULL
operacoes_temp$`Taxa da CBLC` <- NULL
operacoes_temp$`Outras Despesas` <- NULL

# Alterando as posições das colunas
operacoes_temp <- operacoes_temp[, c(1, 2, 3, 4, 5, 6, 9, 7, 8)]

# Inserindo o valor FALSE nas células vazias da coluna 'Subscricao'
operacoes_temp$Subscricao[is.na(operacoes_temp$Subscricao)] <- FALSE

# Alterando os noems das colunas
colnames(operacoes_temp) <- c("Ticker", "Operacao", "Nr_Cotas" ,"Data_Operacao",
                              "Preco_Unitario", "Preco_Total", "Despesas",
                              "Preco_Final", "Subscricao")

# Transformando a coluna 'Data_Operacao' no tipo date
operacoes_temp$Data_Operacao <- as.Date(operacoes_temp$Data_Operacao)

# Selecionando os dados de venda dos ativos
df_vendas <- subset(operacoes_temp, Operacao == "VENDA", 
                    select = c("Ticker", "Data_Operacao", "Nr_Cotas", "Preco_Final"))

# Calculando o valor total vendido
apply(operacoes_temp[, 4], 2, sum)

# Calculando o valor vendido por ativo
vendas_por_ativo <- tapply(df_vendas$Preco_Final, df_vendas$Ticker, sum)

vendas_por_ativo <- round(vendas_por_ativo, 2) * -1

df_vendas_ativo <- data.frame(vendas_por_ativo)
 