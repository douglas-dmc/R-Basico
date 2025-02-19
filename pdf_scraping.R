################################################################################
#                                                                              #
#                         PDF SCRAPING - NOTAS DE NEGOCIAÇÃO                   #
#                         ÚLTIMA ATUALIZAÇÃO: 2 FEV 2025                       #
#                                                                              #
################################################################################

# Carregando pacote
library(tidyverse)
library(dplyr)
library(pdftools)

#path <- "C:/Users/marqu/Documents/IR 2025/2025-01-31 - XP-NotaNegociacao - BARI11-MFII11-TGAR11-BODB11.pdf"
path <- "C:/Users/marqu/Documents/IR 2024/2024-12-05- XP-NotaNegociacao - BARI11-MFII11-RZTR11-VGHF11.pdf"

# Obtendo o numero de páginas
total_pages <- pdf_info(path)['pages']

# Obtendo o texto do pdf
nota_cor <- pdf_text(path)

nota_cor <- nota_cor %>%
    str_split("\n")

# Obtendo a data de negociação
negotiation_date <- nota_cor[[1]][3] %>%
    str_sub(-10) %>%
    as.Date(format = "%d/%m/%Y")

# Criando a função para obter despesas
obtaining_expenses <- function(raw_data, type_expenses){
    expense_index <- str_which(raw_data, type_expenses)
    expense_value <- raw_data[expense_index] 
    
    if (type_expenses == "I.R.R.F."){
        expense_value <- str_sub(expense_value, -4)
    } else {
        expense_value <- str_sub(expense_value, -6, -2) 
    }
                 
    expense_value %>%
        str_trim() %>%
        str_replace(",", ".") %>%
        as.double()
}

# Criando a lista de dataframes
l_out <- list()

for(n_page in 1:total_pages[[1]]){
    # Dados da página 1
    nota_cor[[n_page]]
    
    # Removendo linhas em branco
    blank_lines <- str_length(nota_cor[[n_page]]) == 0
    
    index_blank_lines <- which(blank_lines)
    
    
    # Definindo os limites de início e fim da tabela 1
    start <- str_which(nota_cor[[n_page]], "Negócios realizados")
    end <- str_which(nota_cor[[n_page]], "Resumo dos Negócios")
    
    # Contando os espaços vazios antes da tabela
    count <- 0
    cond <- TRUE
    index <- end
    while (cond == TRUE){
        if (str_length(nota_cor[[1]][index - 1]) == 0){
            index <- index - 1
            count <- count + 1
            cond <- TRUE
        } else {
            cond <- FALSE
        }
    }
    
    count <- count + 1
    
    # Extraindo a tabela com as negociações
    nota <- nota_cor[[n_page]][(start + 2):(end - count)] %>%
        str_trim() %>%
        str_remove_all("#") %>%
        str_split("\\s{2,}", simplify = F)
    
    # Convertendo a tabela em dataframe
    df <- map_dfr(nota, ~as.data.frame(t(.x)))
    
    # Definindo os títulos das colunas
    if (ncol(df) == 10){
        col_names <- c("Negociacao", "C/V", "Tipo_Mercado", "Titulo", "Ticker", "#",
                    "Quantidade", "Preco", "Valor_Operacao", "D/C")
        test <- FALSE
    } else {
        col_names <- c("Negociacao", "C/V", "Tipo_Mercado", "Titulo", "Ticker",
                       "Quantidade", "Preco", "Valor_Operacao", "D/C")
        test <- TRUE
    }
    
    # Setando as colunas
    names(df) <- col_names
    
    # Removendo colunas indesejadas
    df$`#` <- NULL
    df$Negociacao <- NULL
    
    # Convertendo colunas em fatores
    df$`C/V` <- factor(df$`C/V`, levels = c("C", "V"))
    df$`D/C` <- factor(df$`D/C`, levels = c("D", "C"))
    if (test){
        df$Ticker <- "BODB11"
    }
    df$Ticker <- as.factor(df$Ticker)
    
    # Convertendo a coluna 'Quantidade' em inteiro
    df$Quantidade <- as.integer(df$Quantidade)
    
    # Convertendo a coluna 'Preco' em double
    df$Preco <- str_replace_all(df$Preco, ",", ".")
    df$Preco <- as.double(df$Preco)
    
    # Convertendo a coluna 'Valor_Operacao' em double
    # df$Valor_Operacao <- str_replace_all(df$Valor_Operacao, ",", ".")
    # 
    # for(i in df$Valor_Operacao){
    #     if (i > 7){
    #         df$Valor_Operacao <- str_replace(df$Valor_Operacao, "\\.", ",")
    #     }
    # }
    df$Valor_Operacao <- as.double(df$Valor_Operacao)
    
    
    # Visualizando a estrutura dos dados
    cat("\nVisualizando a estrutura do dataframe", n_page, "\n")
    
    glimpse(df)
    
    l_out[[n_page]] <- df
}

# Juntando os dataframes
df_plus <- full_join(l_out[[1]], l_out[[2]])

df_plus <- full_join(df_plus, l_out[[3]])

# Removendo linhas contendo NA
df_plus <- df_plus %>%
            na.omit()

# Resumindo os dados
df_summary <- df_plus %>% group_by(Ticker) %>%
        summarise(Cotas = sum(Quantidade), 
                  Preco = sum(Valor_Operacao)) %>%
        mutate(Preco_Unitario = Preco / Cotas, 
               .after = Cotas)

# Acrescentando a data de negociação no dataframe
df_summary %>% mutate(Data = negotiation_date) %>%
    select(Data, everything())



# Obtendo a taxa de emolumentos da B3
emolumentos <- obtaining_expenses(nota_cor[[2]], "Emolumentos")

# Obtendo a taxa de liquidação da CBLC
cblc <- obtaining_expenses(nota_cor[[2]], "Taxa de liquidação")

# Obtendo o imposto de renda retido na fonte (IRRF)
tax_irrf <- obtaining_expenses(nota_cor[[2]], "I.R.R.F.")

# Obtendo outras despesas
expenses <- obtaining_expenses(nota_cor[[2]], "Total Custos / Despesas")

# Obtendo as despesas totais
total_expenses <- emolumentos + cblc + tax_irrf + expenses









