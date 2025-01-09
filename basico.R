################################################################################
#                                                                              #
#                         ESTUDO BÁSICO DE R                                   #
#                         ÚLTIMA ATUALIZAÇÃO: 03 JAN 2025                      #
#                                                                              #
################################################################################

# R é uma linguagem de computação estatística, orientada a objetos, voltada à
# manipulação, análise e visualização de dados.

# Tipos de dados: escalares, vetores (linha ou coluna), matrizes,
#                 dataframes e listas

# Criando variáveis
n = 10
d <- 5
7 -> s
nome <- "douglas"
.sobrenome <- "costa"  # variável oculta (iniciada com ponto final)
vetor <- c(1, 4, 5, 8)    # concatena elementos (c())

seq <- seq(3, 20, 2)  # gera uma sequência de 3 a 20, de 2 em 2
seq(0, 1, length.out = 12) # gera sequência de 0 1 com 12 elementos
seq(18)      # cria uma sequência 1, 2, 3, ... , 18

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
s1 <- rep(s, times = 5)  # repete todo o vetores cinco vezes
s2 <- rep(s, each = 5)   # repete cada elemento de s cinco vezes

# Listando e removendo objetos da memória
ls()       # lista todos os objetos
objects()  # faz o mesmo que ls()
ls.str()   # lista todos os objetos de forma estruturada
ls(pattern = "o", all.names = TRUE)  # lista os objetos que correspondem as
#          opções fornecidas:
#                           pattern: expessão regular
#                           all.names: TRUE -> lista variáveis ocultas tbm.
rm(s)     # remove a variável s
rm(list = ls())      # remove todas as variáveis da memória

# Instalando pacotes
install.packages("dplyr")

pacotes <- installed.packages()  # lista os pacotes instalados

n_pacotes <- length(pacotes)

# Pedindo ajuda online
? lm
help(rm)
help.start()

# Entendendo objetos

# Objetos possuem: nome
#                  conteúdo
#                  atributos: - mode: numerico, caracter, complexo e lógico
#                             - length: nº de elementos

x <- 9
y <- c(3, 5, 6)
z <- "paulo"
a <- c(2, "lua", 8)  # um elemento caracter converte os outros em caracter!

mode(x)
mode(y)
mode(z)
mode(a)

length(x)
length(y)
length(z)

vector(mode = "numeric", length = 4) # cria um vetor numérico com 4 elementos
numeric(4)  # faz o mesmo que o comando acima

vector(mode = "logical", length = 4) # cria um vetor lógico com 4 elementos
logical(4)  # faz o mesmo que o comando acima

vector(mode = "character", length = 4) # cria um vetor de caracteres com 4 elementos
character(4) # faz o mesmo que o comando acima

is.vector(a)  # verifica se a é um vetor e dá um retorno lógico (TRUE/FALSE)

vetor_logico <- y > 13 # vetor lógico

# == igual
# != diferente
# >= maior ou igual
# <= menor ou igual
# v1 & v2 interseção
# v1 | v2 união
# !v1 negação

vetor_nan <- c(1, 0 / 0, 3.5, Inf)

vetor_logico2 <- is.nan(vetor_nan) # cria um vetor lógico com o valor TRUE
#                                    para o correspondente NaN

z <- c(1:3, NA)
int <- is.na(z) # cria um vetor lógico com o valor TRUE para o correspondente NA

mat1 <- matrix(1:9, nrow = 3, ncol = 3)  # cria uma matriz 3x3

mat2 <- matrix(1:9,
               nrow = 3,
               ncol = 3,
               dimnames = list(c("y1", "y2", "y3"), c("x1", "x2", "x3")))

t <- 1:3
d <- c("x1", "x2", "x3")
df1 <- data.frame(t, d)   # cria um dataframe

lista_var <- list(x = 1:5, y = c("a", "b"))  # cria uma lista

exp1 <- expression(x / (y + exp(z)))  # cria uma expressão
eval(exp1, envir = list(x = 3, y = 2.5, z = 1)) # avalia uma expressão

# Resumindo dados
summary(df) # visualiza dados estatísticos do objeto
str(df)     # visualiza a estrutura do objeto
names(df)   # lista os nomes dos elementos do objeto
class(df)   # recupera a classe interna do objeto

# Imprimindo objetos na tela
print(a)
print(a, quote = F)  # imprimindo caracteres sem aspas

b <- 2.6238
print(b, digits = 2) # imprimindo com número de dígitos definido

c <- table(c(0, 3, 4), c(3, 6, 0))
print(c, zero.print = ".")  # imprimindo com ponto no lugar dos zeros (p/ tabelas)

# Carregando e anexando pacotes
library()    # lista todos os pacotes disponiveis da versão vigente
library(lib.loc = .Library)  # lista todos os pacotes na biblioteca padrão
library(help = dplyr)
library(dplyr)  # carrega o pacote dplyr
require(dplyr)  # carrega o pacote dplyr (usado em funções: retorna FALSE se o pacote não existe)

search()  # lista os pacotes anexados e objetos anexados
searchpaths()  # lista os pacotes e objetos anexados com o caminho

# Lendo dados de arquivo
dir <- getwd() # obtem o diretório atual
setwd(dir) # seta o diretório atual

tab <- read.csv(
  "Relação_OM_EB.csv",
  # nome do arquivo
  sep = ";",
  # separador de colunas
  header = TRUE,
  col.names = c("Rm", "Codom", "Unidade"),
  # nomes das colunas
  skip = 0,
  # nº de linhas puladas antes de ler o arquivo
  fileEncoding = "latin1",
  # codificação do arquivo
  stringsAsFactors = F
) # não converte string em fatores

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
  blank.lines.skip = T
) # ignora linhas em blanco


library(readxl)  # Carrega o pacote para ler arquivos excel

ativos <- read_xlsx(
  "ativos.xlsx",
  sheet = 1,
  # define a planilha
  range = "A1:M29",
  # define as células
  col_names = TRUE,
  # define a 1ª linha como título
  progress = readxl_progress(),
  skip = 0
)

operacoes <- read_xlsx(
  "ativos.xlsx",
  sheet = 5,
  # define a planilha
  col_names = TRUE,
  # define a 1ª linha como título
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

planilhas <- excel_sheets("ativos.xlsx")  # lista os nomes das planilhas

# Cria uma lista com as planilhas do arquivo excel por iteração
lista <- lapply(excel_sheets("ativos.xlsx"), read_excel, path = "ativos.xlsx")

# Salvando e carregando espaço de trabalho
save.image(file = "basico.RData")

load("basico.RData")

# Exportando arquivos
write.csv(df, file = "dados_df.csv")  # csv

write.table(df, file = "dados_df.txt", sep = "\t")  # bloco de notas

library(writexl)
write_xlsx(df, path = "dados_df.xlsx")  # excel

saveRDS(df, "dados_rds.RDS") # arquivo do R

# Funções básicas
v1 <- c(2, 4, 7, 8.5, 3)
v2 <- c(3, 8, 9, 2.4, 5)

max(v1)    # valor máximo do vetor v1
min(v2)    # valor mínimo do vetor v2
sum(v1)    # soma dos elementos de v1
prod(v2)   # produto dos elementos de v2
range(v1)  # vetor de 2 dimensões com os valores mínimos e máximos de v1
mean(v2)   # valor médio de v2
sort(v1)   # ordena os elementos de v1 em ordem crescente
sort(v1, decreasing = T) # ordena os elementos de v1 em ordem decrescente

# Desvia toda a saída subsequente do console para o arquivo record.txt
sink(file = "record.txt",  # arquivo que receberá a saída
     append = FALSE,       # FALSE: grava por cima do arquivo
     type = "output")      # output: só desvia a saída; message: desvia as advertências

# executando comando de um arquivo externo
source("simulação_monte_carlo.R")

sink()

# Selecionando e modificando subconjuntos de dados
x <- c(1, 2, 4, NA, 9, 15, NA, 22)
x[x >= 5] <- 20 # x: 1 2 4 NA 20 20 NA 20
x[1:5] # seleciona os 5 primeiros elementos de x
x[-(1:5)] # exclui os 5 primeiros elementos de x
x[is.na(x)] <- 0 # substitui os valores omissos por zero

x <- c(1, -2, 4, NA, 9, 15, NA, 22)
y <- x[!is.na(x)]  # remove valores NA
y <- abs(y)

(x+1)[!is.na(x) & x>0] -> z # cria o vetor z com os valores não omisso 
# e positivos de x, acrescidos de um

# Indexando vetor de caracteres
fruit <- c(1, 10, 5, 20) # criando os índices
names(fruit) <- c("orange", "apple", "banana", "peach")
lunch <- fruit[c("orange", "apple")]

