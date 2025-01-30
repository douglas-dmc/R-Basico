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
# dep_time, arr_time   : horários programados de partida e chegada (HHMM ou HMM)
# dep_delay, arr_delay : atrasos de partida e chegada, em minutos
# carrier              : abreviação da operadora aérea (2 letras)
# flight               : número do vôo
# tailnum              : número da cauda do avião
# origin, dest         : origem e destino (aeroportos)
# air_time             : tempo gasto no ar, em minutos
# distance             : distância entre aeroportos, em milhas
# hour, minute         : tempo da partida programada dividida em horas e minutos
# time_hour            : data e hora programada do vôo

#-------------------------- Função filter() ------------------------------------

# Filtrando os dados de 1º de janeiro
filter(flights, month == 1, day == 1)

# Filtrando os dados de novembro e dezembro
filter(flights, month %in% c(11, 12))

# Filtrando valores omissos da variável dep_time
filter(flights, is.na(dep_time))

# Filtrando os vôos que partiram entre meia noite e seis da manhã
filter(flights, between(dep_time, 600, 1200))

#-------------------------- Função distinct() ----------------------------------

# Obtendo a relação das empresas aéreas (2 letras)
carriers <- distinct(flights, carrier)

# Achando o número de empresas aéreas
nrow(carriers)

#-------------------------- Função arrange() -----------------------------------

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

arrange(flights, desc(month), day, .group_by = carrier) # dados agrupados

# Usando função personalizada para reordenar os dados
fun_arrange <- function(.data, var){
    arrange(.data, {{ var }}) # é necessário envolver a coluna com chaves duplas
}

fun_arrange(flights, carrier)

# Usando a função de 'data-masking' pick()
arrange(flights, pick(month, day))

# Usando a função de 'data-masking' across()
arrange(flights, across(starts_with("dep"), desc))

arrange(flights, across(ends_with("time"), desc))

#------------------------- Função select() -------------------------------------

# Selecionando as colunas por índices
select(flights, 2:5)

# selecionando colunas pelo nome
select(flights, year, month, day)

# Selecionando intervalo de colunas
select(flights, year:dep_delay)

# Selecionando todas as colunas exceto as especificadas
select(flights, -(year:dep_delay))

# Selecionando colunas com a função starts_with()
select(flights, starts_with("dep"))

select(flights, starts_with(c("dep", "arr")))

# Selecionando colunas com a função ends_with()
select(flights, ends_with("time"))

select(flights, ends_with(c("time", "delay")))

# Selecionando as colunas que não terminam com 'time' e nem com 'delay'
select(flights, !ends_with("time") & !ends_with("delay"))

# Selecionando a última coluna do dataframe
select(flights, last_col())

# Selecionando colunas com a função contains()
select(flights, contains("de"))

# Selecionando colunas no modo case sensitive
select(flights, contains("TIME", ignore.case = FALSE))

# Selecionando colunas com a função matches()
select(flights, matches("(.)\\1")) # utiliza uma expressão regular

# Reposicionando colunas para o início do dataframe
select(flights, time_hour, air_time, everything())

# Selecionando todas as colunas numéricas
select_if(flights, is.numeric)

# Selecionando colunas com a função where()
select(flights, where(is.numeric))
select(flights, where(~ is.numeric(.x))) # resultado igual ao código anterior

# Selecionando colunas numéricas com média superior a um valor
select(flights, where(~ is.numeric(.x) && mean(.x, na.rm = TRUE) > 400))

# Selecionando colunas com vetores: all_of() e any_of()
vars <- c("dep_time", "dep_delay", "arr_time", "arr_delay")

select(flights, all_of(vars)) # seleciona todas as varisveis do vetor. 
# Se o vetor tiver alguma variavel não correspondente a colunas do dataframe
# haverá um erro

vars <- c("dep_time", "dep_delay", "arr_time", "arr_delay", "source")

select(flights, any_of(vars)) # seleciona, somente, as colunas que correspondem
# às variáveis do vetor

#-------------------------- Função rename() ------------------------------------

# Renomeando colunas
rename(flights, tail_num = tailnum)

# Renomeando com as funções predicadas
nams <- c(tail_num = "tailnum", destine = "dest")

rename(flights, all_of(nams))

# Renomeando com a função rename_with()
rename_with(flights, toupper, month)

rename_with(flights, tolower, month)

rename_with(flights, toupper, starts_with("dep"))

#-------------------------- Função mutate() ------------------------------------

# Adicionando duas novas colunas que são funções de colunas existentes
flights_new <- select(flights, year:day, ends_with("delay"), distance, air_time)

mutate(flights_new, gain = arr_delay - dep_delay,
                    speed = distance / air_time)

# Mantendo apenas as colunas criadas em outro dataframe: transmute()
transmute(flights, gain = arr_delay - dep_delay,
                   hours = air_time / 60,
                   gain_per_hour = gain / hours)

# Escolhendo o posicionamento das novas colunas 
mutate(flights_new, gain = arr_delay - dep_delay,
       speed = distance / air_time, .before = day)

mutate(flights_new, gain = arr_delay - dep_delay,
       speed = distance / air_time, .after = day)

# Deletando e modificando colunas
mutate(flights_new, year = NULL,
                    distance = distance * 1.60934) # convertendo milhas para km

# Modificando várias colunas: across()
mutate(flights_new, across(ends_with("delay"), 
                           function(x){ x - mean(x, na.rm = T) }))

# Aplicando uma transformação a multiplas colunas
mutate(flights, across(tailnum:dest, as.factor))

# Referenciando nomes de colunas estocadas com strings com .data
vars <- c("hour", "minute")

flights %>%
    mutate(min_total = .data[[vars[[1]]]] * 60 + .data[[vars[[2]]]], 
           .keep = "used")

# Atuando sobre variaveis selecionadas com um vetor caracter
mutate_at(flights, c("hour", "minute"), ~ .x * 60) %>% View

#--------------------------- Função summarize() --------------------------------

# Calculando a média do atraso na chegada
summarise(flights, delay = mean(dep_delay, 
                                na.rm = TRUE)) # gera uma linha de resposta

# Calculando a média de atraso na chegada por dia
by_day <- group_by(flights, year, month, day)

summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

# Obtendo a relação entre a distância e o atraso médios para cada destino
# Agrupando pelo destino
by_dest <- group_by(flights, dest)

# Resumindo a distância média, o atraso médio e o nr de vôos
delay <- summarise(by_dest, 
                   count = n(),
                   dist = mean(distance, na.rm = T),
                   delay = mean(arr_delay, na.rm = T))

# Filtrando para remover pontos ruidosos e o aeroporto de Honolulu (muito longe)
delay <- filter(delay, count > 20, dest != "HNL")

ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
    geom_point(aes(size = count), alpha = 1/3) +
    geom_smooth(se = F)

# Reescrevendo o código acima com o operador pipe (%>%)
group_by(flights, dest) %>%
    summarise(count = n(),
              dist = mean(distance, na.rm = T),
              delay = mean(arr_delay, na.rm = T)) %>%
    filter(count > 20, dest != "HNL") %>%
    ggplot(mapping = aes(x = dist, y = delay)) +
    geom_point(aes(size = count), alpha = 1/3) +
    geom_smooth(se = F)

# Calculando a média sem usar 'na.rm' na função 'mean'
not_cancelled <- flights %>%
    filter(!is.na(arr_delay), !is.na(dep_delay))

delays <- not_cancelled %>%
    group_by(tailnum) %>%
    summarise(delay = mean(arr_delay))

    ggplot(data = delays, mapping = aes(x = delay)) +
    geom_freqpoly(binwidth = 10)
    
delays <- not_cancelled %>%
    group_by(tailnum) %>%
    summarise(delay = mean(arr_delay, na.rm = T),
              n = n())

    ggplot(data = delays, mapping = aes(x = n, y = delay)) +
    geom_point(alpha = 1/10)
    
#------------------------- Função slice() --------------------------------------
    
# Selecionando as linhas 20 até 30
slice(flights, 20:30)
    
# Selecionando todas as linhas menos 1 até 5
slice(flights, -(1:5))

