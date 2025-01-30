################################################################################
#                                                                              #
#                         ESTUDO BÁSICO DE tidyr                               #
#                         ÚLTIMA ATUALIZAÇÃO: 30 JAN 2025                      #
#                                                                              #
################################################################################

# Carregando pacote
library(tidyr)

#---------------------------- Função separate() --------------------------------

# Criando o dataframe
df <- tibble(x = c(NA, "x.y", "x.z", "y.z"))

# Separando as variáveis do df
df %>%
    separate(x, c("A", "B"))

# Separando variáveis com delimitador
df %>%
    separate_wider_delim(x, ".", names = c("A", "B"))

# Separando variáveis com os argumentos 'extra' e 'fill'
df <- tibble(x = c("x", "x y", "x y z", NA))

df %>%
    separate(x, c("a", "b"), extra = "drop", fill = "right")

df %>%
    separate(x, c("a", "b"), extra = "merge", fill = "left")

#----------------------------- Função pivot_longer() ---------------------------

# Carregando dados (relig_income)
data("relig_income")

# Visualizando a estrutura dos dados
glimpse(relig_income)

# Convertendo de wide para long
relig_income %>%
    pivot_longer(cols = !religion,
                 names_to = "income",
                 values_to = "count")

# Carregando os dados (billboard)
data("billboard")

# Visualiando a estrutura dos dados
glimpse(billboard)

# Convertendo o df de wide para long
billboard %>%
    pivot_longer(cols = starts_with("wk"),
                 names_to = "week",
                 names_prefix = "wk",  # remove o prefixo "wk" do número
                 names_transform = as.integer, # converte "week" em inteiro
                 values_to = "rank",
                 values_drop_na = TRUE)

# Carregando os dados (who)
data("who")

# Visualizando a estrutura dos dados
glimpse(who)

# Convertendo o df de wide para long
who %>%
    pivot_longer(cols = new_sp_m014:newrel_f65,
                 names_to = c('diagnosis', "gender", "age"),
                 values_to = "count",
                 names_pattern = "new_?(.*)_(.)(.*)")


# Carregando os dados (anscombe)
data("anscombe")

# Convertendo o df de wide para long
anscombe %>%
    pivot_longer(cols = everything(),
                 names_to = c(".value", "set"),
                 cols_vary = "slowest",
                 names_pattern = "(.)(.)")
