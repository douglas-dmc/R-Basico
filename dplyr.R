################################################################################
#                                                                              #
#                         ESTUDO BÁSICO DE dplyr                               #
#                         ÚLTIMA ATUALIZAÇÃO: 18 JAN 2025                      #
#                                                                              #
################################################################################

# Carregando pacotes
library(tidyverse)
library(nycflights13) # dataset dos vôos do New York City de 2013

# Carregando os dados dos vôos
data(flights)

# Visualizando a estrutura dos dados
str(flights)

# Entendendo o dataset
?flights

# year, month, day     : data de partida
# dep_time, arr_time   : horários programados de partida e chegada
# dep_delay, arr_delay : atrasos de partida e chegada, em minutos
# carrier              : abreviação da operadora aérea
# flight               : número do vôo
# tailnum              : número da cauda do avião
# origin, dest         : origem e destino
# air_time             : tempo gasto no ar, em minutos
# distance             : distância entre aeroportos, em milhas
# hour, minute         : hora da partida programada dividida em horas e minutos
# time_hour            : data e hora programada do vôo

# Função filter()

# Filtrando os dados de 1º de janeiro
filter(flights, month == 1, day == 1)

# Filtrando os dados de novembro e dezembro
filter(flights, month %in% c(11, 12))

# Filtrando valores omissos da variável dep_time
filter(flights, is.na(dep_time))

# Filtrando os vôos que partiram entre meia noite e seis da manhã
filter(flights, between(dep_time, 600, 1200))

# Função arrange()

# Reordenando os dados em ordem crescente de mês
arrange(flights, month)

# Reordenando os dados em ordem decrescente de mês - desc()
arrange(flights, desc(month))

# Reordenando os dados com mais de um nome de coluna
arrange(flights, month, day)  # valores iguais de mês são ordenados em dia

# Reordenando dados grupados pela operadora de võo (carrier)
grupo <- group_by(flights, carrier)
arrange(grupo, desc(month))  # os dados não foram agrupados por carrier

arrange(grupo, desc(month), .by_group = TRUE) # os dados foram agrupados

# Usando função personalizada para reordenar os dados
fun_arrange <- function(.data, var){
    arrange(.data, {{ var }}) # é necessário envolver a coluna com chaves duplas
}

fun_arrange(flights, carrier)

# Usando funções de 'data-masking'
arrange(pick(month, day))
