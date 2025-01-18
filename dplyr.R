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

# Visualizando os dados
str(flights)

# Entendendo o dataset
?flights

# year, month, day     : data de partida
# dep_time, arr_time   : horários programados de partida e chegada
# dep_delay, arr_delay : atrasos de partida e chegada, em minutos
# carrier              : abreviação da operadora
# flight               : número do vôo
# tailnum              : número da cauda do avião
# origin, dest         : origem e destino
# air_time             : tempo gasto no ar, em minutos
# distance             : distância entre aeroportos, em milhas
# hour, minute         : hora da partida programada dividida em horas e minutos
# time_hour            : data e hora programada do vôo

# função filter()

# Filtrando os dados de 1º de janeiro
filter(flights, month == 1, day == 1)

# Filtrando os dados de novembro e dembro
filter(flights, month %in% c(11, 12))
