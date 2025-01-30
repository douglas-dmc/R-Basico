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
