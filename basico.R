################################################################################
#                                                                              #
#                         ESTUDO BÁSICO DE R                                   #
#                         ÚLTIMA ATUALIZAÇÃO: 08 JAN 2025                      #
#                                                                              #
################################################################################

# R é uma linguagem de computação estatística, orientada a objetos, voltada à
# manipulação, análise e visualização de dados.

# Tipos de dados: escalares, vetores (linha ou coluna), matrizes,
#                 dataframes e listas

# CRIANDO VARIÁVEIS

n = 10
d <- 5
7 -> s
nome <- "douglas"

# Variável oculta (iniciada com ponto final)
.sobrenome <- "costa"  
# Concatena elementos (c())
vetor <- c(1, 4, 5, 8)    

# Gera uma sequência de 3 a 20, de 2 em 2
seq <- seq(3, 20, 2)  
# Gera sequência de 0 1 com 12 elementos
seq(0, 1, length.out = 12) 
# Cria uma sequência 1, 2, 3, ... , 18
seq(18)      

# Cria um sequência de datas por ano
seq(as.Date("2020/01/01"), as.Date("2025/01/01"), "years")

# Cria uma sequência de datas por mês
seq(as.Date("2000/01/01"), as.Date("2024/1/1"), by = "month")

# Cria uma sequência de datas por trimestre
seq(as.Date("2024/01/01"), as.Date("2025/01/01"), by = "quarter")

# Cria uma sequência de datas por mês decrescente
seq(as.Date("2025/01/01"), as.Date("2023/01/01"), by = "-1 month")

# Cria uma sequência de datas e horas por dia (ISOdate())
seq(ISOdate(2000, 3, 20), by = "3 days", length.out = 10)

seq(ISOdate(2000, 3, 20), by = "7 DSTdays", length.out = 10)

# ISOdatetime(ano, mês, dia, hora, minuto, segundo, zona de tempo)
seq(ISOdatetime(2025, 1, 7, 8, 10, 0, "GMT"),
    ISOdatetime(2025, 1, 7, 13, 10, 0, "GMT"),
    "15 min")

s <- c(1, 2, 3, 4)
# Repete todo o vetores cinco vezes
s1 <- rep(s, times = 5)  
# Repete cada elemento de s cinco vezes
s2 <- rep(s, each = 5)   

# LISTANDO E REMOVENDO OBJETOS DA MEMÓRIA

# Lista todos os objetos
ls()      
# Faz o mesmo que ls()
objects() 
# Lista todos os objetos de forma estruturada
ls.str()   
# Lista os objetos que correspondem as
#          opções fornecidas:
#                           pattern: expessão regular
#                           all.names: TRUE -> lista variáveis ocultas tbm.
ls(pattern = "o", all.names = TRUE)  
# Remove a variável s
rm(s)   
# Remove todas as variáveis da memória
rm(list = ls())     

# INSTALANDO PACOTES

install.packages("dplyr")

# Lista os pacotes instalados
pacotes <- installed.packages()  

n_pacotes <- length(pacotes)

# PEDINDO AJUDA ONLINE

? lm
help(rm)
help.start()

# ENTENDENDO OBJETOS

# Objetos possuem: nome
#                  conteúdo
#                  atributos: - mode: numerico, caracter, complexo e lógico
#                             - length: nº de elementos

x <- 9
y <- c(3, 5, 6)
z <- "paulo"
# Um elemento caracter converte os outros em caracter!
a <- c(2, "lua", 8)  

mode(x); mode(y); mode(z); mode(a)

length(x); length(y); length(z)

# Cria um vetor numérico com 4 elementos
vector(mode = "numeric", length = 4) 
# Faz o mesmo que o comando acima
numeric(4)  

# Cria um vetor lógico com 4 elementos
vector(mode = "logical", length = 4) 
# Faz o mesmo que o comando acima
logical(4)  

# Cria um vetor de caracteres com 4 elementos
vector(mode = "character", length = 4) 
# Faz o mesmo que o comando acima
character(4) 

# Verifica se a é um vetor e dá um retorno lógico (TRUE/FALSE)
is.vector(a)  

# Vetor lógico
vetor_logico <- y > 13 

# == igual
# != diferente
# >= maior ou igual
# <= menor ou igual
# v1 & v2 interseção
# v1 | v2 união
# !v1 negação

vetor_nan <- c(1, 0 / 0, 3.5, Inf)

# cria um vetor lógico com o valor TRUE para o correspondente NaN
vetor_logico2 <- is.nan(vetor_nan) 

z <- c(1:3, NA)
# Cria um vetor lógico com o valor TRUE para o correspondente NA
int <- is.na(z) 

# Cria uma matriz 3x3
mat1 <- matrix(1:9, nrow = 3, ncol = 3)  

mat2 <- matrix(1:9,
               nrow = 3,
               ncol = 3,
               dimnames = list(c("y1", "y2", "y3"), c("x1", "x2", "x3")))

t <- 1:3
d <- c("x1", "x2", "x3")
# Cria um dataframe
df1 <- data.frame(t, d)   

# Cria uma lista
lista_var <- list(x = 1:5, y = c("a", "b"))  

# Cria uma expressão
exp1 <- expression(x / (y + exp(z)))  
eval(exp1, envir = list(x = 3, y = 2.5, z = 1)) # avalia uma expressão

# RESUMINDO DADOS

# Visualiza dados estatísticos do objeto
summary(df) 
# Visualiza a estrutura do objeto
str(df)   
# Lista os nomes dos elementos do objeto
names(df)   
# Recupera a classe interna do objeto
class(df)   

# IMPRIMINDO OBJETOS NA TELA
print(a)
# Imprimindo caracteres sem aspas
print(a, quote = F)  

b <- 2.6238
# Imprimindo com número de dígitos definido
print(b, digits = 2) 

c <- table(c(0, 3, 4), c(3, 6, 0))
# Imprimindo com ponto no lugar dos zeros (p/ tabelas)
print(c, zero.print = ".")  

# CARREGANDO E ANEXANDO PACOTES

# Lista todos os pacotes disponiveis da versão vigente
library()    
# Lista todos os pacotes na biblioteca padrão
library(lib.loc = .Library)  
library(help = dplyr)
# Carrega o pacote dplyr
library(dplyr)  
# Carrega o pacote dplyr (usado em funções: retorna FALSE se o pacote não existe)
require(dplyr)  

# Lista os pacotes anexados e objetos anexados
search()  
# Lista os pacotes e objetos anexados com o caminho
searchpaths()  

# LENDO DADOS DE ARQUIVO

# Obtem o diretório atual
dir <- getwd()
# Seta o diretório atual
setwd(dir) 

tab <- read.csv(
              # nome do arquivo
              "Relação_OM_EB.csv",
              # separador de colunas
              sep = ";",
              header = TRUE,
              # nomes das colunas
              col.names = c("Rm", "Codom", "Unidade"),
              # nº de linhas puladas antes de ler o arquivo
              skip = 0,
              # codificação do arquivo
              fileEncoding = "latin1",
              # não converte string em fatores
              stringsAsFactors = F
            ) 

ope <- read.csv("operacoes.csv",
                sep = ",",
                header = T,
                dec = ",")

dat <- read.csv("wdbc.csv",
                sep = ",",
                header = F,
                dec = ",")

fope <- read.csv(
              "foperacoes.csv",
              sep = ";",
              header = T,
              fileEncoding = "latin1",
              # ignora linhas em blanco
              blank.lines.skip = T
            ) 

# Carrega o pacote para ler arquivos excel
library(readxl)  

ativos <- read_xlsx(
                  "ativos.xlsx",
                  # define a planilha
                  sheet = 1,
                  # define as células
                  range = "A1:M29",
                  # define a 1ª linha como título
                  col_names = TRUE,
                  progress = readxl_progress(),
                  skip = 0
                )

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

# read_xls   -> para arquivos com extensão .xls
# read_xlsx  -> para arquivos com extensão .xlsx
# read_excel -> quando não se tem certeza do tipo de extensão (.xls ou .xlsx)

# Usando cell-specification (cell_cols(), cell_rows(), cell_limits() e anchored())
df <- read_excel("ativos.xlsx", sheet = "fOperacoes", range = cell_cols("A:F"))

# Lista os nomes das planilhas
planilhas <- excel_sheets("ativos.xlsx")  

# Cria uma lista com as planilhas do arquivo excel por iteração
lista <- lapply(excel_sheets("ativos.xlsx"), read_excel, path = "ativos.xlsx")

# Salvando e carregando espaço de trabalho
save.image(file = "basico.RData")

load("basico.RData")

# EXPORTANDO ARQUIVOS

# Formato css
write.csv(df, file = "dados_df.csv")  

# Formato bloco de notas
write.table(df, file = "dados_df.txt", sep = "\t")  

# Formato excel
library(writexl)
write_xlsx(df, path = "dados_df.xlsx") 

# Formato R
saveRDS(df, "dados_rds.RDS")

# Funções básicas
v1 <- c(2, 4, 7, 8.5, 3)
v2 <- c(3, 8, 9, 2.4, 5)

# Valor máximo do vetor v1
max(v1)   
# Valor mínimo do vetor v2
min(v2)  
# Soma dos elementos de v1
sum(v1)  
# Produto dos elementos de v2
prod(v2)
# Vetor de 2 dimensões com os valores mínimos e máximos de v1
range(v1)  
# Valor médio de v2
mean(v2) 
# Ordena os elementos de v1 em ordem crescente
sort(v1) 
# Ordena os elementos de v1 em ordem decrescente
sort(v1, decreasing = T) 

# Desvia toda a saída subsequente do console para o arquivo record.txt
sink(# arquivo que receberá a saída
     file = "record.txt",  
     # FALSE: grava por cima do arquivo
     append = FALSE, 
     # output: só desvia a saída; message: desvia as advertências
     type = "output")     

# Executando comando de um arquivo externo
source("simulação_monte_carlo.R")

sink()

# SELECIONANDO E MODIFICANDO SUBCONJUNTO DE DADOS

x <- c(1, 2, 4, NA, 9, 15, NA, 22)

# x: 1 2 4 NA 20 20 NA 20
x[x >= 5] <- 20 
# Seleciona os 5 primeiros elementos de x
x[1:5] 
# Exclui os 5 primeiros elementos de x
x[-(1:5)] 
# Substitui os valores omissos por zero
x[is.na(x)] <- 0 

x <- c(1, -2, 4, NA, 9, 15, NA, 22)

# Remove valores NA
y <- x[!is.na(x)]  
y <- abs(y)

# Cria o vetor z com os valores não omisso e positivos de x, acrescidos de um
(x+1)[!is.na(x) & x>0] -> z  

# Indexando vetor de caracteres
# Criando os índices
fruit <- c(1, 10, 5, 20) 
names(fruit) <- c("orange", "apple", "banana", "peach")
lunch <- fruit[c("orange", "apple")]

# FATORES

estados <- c("SP", "RJ", "RJ", "RS", "BA", "PR",
             "ES", "SP", "MG", "BA", "MT", "MG")

# Cria os fatores
estados_ef <- factor(estados)

# Fornece os níveis
levels(estados_ef)

# Cria o vetor de rendas a serem aplicadas aos estados
renda <- c(75, 70, 80, 65, 70, 75, 65, 70, 70, 80, 75, 60)

# Calcula a renda média amostral para cada estado
renda_media <- tapply(renda, estados_ef, mean)

# FUNÇÃO apply(): APLICADA SOBRE MATRIZ OU DATAFRAME

# Carregando o conjunto de dados irir
library(dados)
View(iris)

# Calculando a média sobre os valores das linhas
apply(iris[, 1:4], 1, mean)

# Calculando a média sobre os valores das colunas
apply(iris[, 1:4], 2, mean)

# Usando uma função personalizada
apply(iris[, 1:4], 2, function(x){
    mean(x) * 0.5
})

# FUNÇÃO lapply(): RECEBE VETOR, LISTA OU DATAFRAME E SEMPRE GERA UMA LISTA

r <- list(a = 1:10, b = 1:63, c = 52:73, d = 54:2)

# Calculando a média de cada elemento da lista
lapply(r, mean)

# Usando uma função personalizada
lapply(r, function(i){
    mean(i * 5)
})

# FUNÇÃO sapply(): FORMA SIMPLIFICADA DO lapply() - GERA UM VETOR PARA UM VETOR, 
#                  UMA LISTA PARA UMA LISTA E UMA MATRIS PARA UM DATAFRAME

# Vetor que gera outro vetor
sapply(c(1,3,5,7), function(x){
    x <- x ** 2
})

# Dataframe que gera uma matriz
sapply(data.frame(1:3, 6:8, 10:12), function(w){
    w <- w * 10
})

# FUNÇÃO tapply(): USADA COM FATORES

tapply(iris$Sepal.Length, iris$Species, mean)

# FUNÇÃO mapply(): VERSÃO MULTIVARIADA DE sapply()

# As duas linhas de código a seguir produzem a mesma saída
mapply(rep, 1:4, 4:1)

list(rep(1,4), rep(2,3), rep(3,2), 4)

# FUNÇÃO with(): ATUA SOMENTE SOBRE DATAFRAME E GERA UM VETOR COMO RESULTADO

num <- c(rep(100, 5))
cost <- c(1200, 1300, 1400, 1500, 1600)

df_with <- data.frame(num, cost)

with(df_with, num * cost)

# FUNÇÃO within(): COPIA O DATAFRAME E ADICIONA UMA COLUNA COM O RESULTADO DA EXPRESSÃO

df_within <- within(df_with, Produto <-  num * cost)

# FUNÇÃO ifelse(): ifelse(vetor_condições, valor_TRUE, valor_FALSE)

nun <- c(2, 4, 7, 9, 16, 21, 22, 41)
ifelse(nun %% 2 == 0, "par", "impar")
