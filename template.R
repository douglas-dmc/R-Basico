#------------------------------------------------------------------------------#
#                                                                              #
#                     SCRIPT PARA EXECUÇÃO DE UM PROJETO R                     #
#                                                                              #
#------------------------------------------------------------------------------#                                                                                                                                       

# Limpanado o espaço de trabalho
rm(list - ls())

# Fechando todas as janelas ativas
graphics.off()

# Carregando pacotes
library(tidyverse)

# Mudando o diretório
my_dir <- "C:/Users/marqu/Documents/R-Basico"

setwd(my_dir)

# Listando funções
my_funcs <- list.files(path = "R_funcs",
                       pattern = ".R",
                       full.names = TRUE)

# Carregando todas as funções no R
sapply(my_funcs, source)

# Importando o script de dados
source("import-and-clean-data.R")  # nome ficticio

# Corregando o modelo e visualizando os resultados
source("run.R") 

