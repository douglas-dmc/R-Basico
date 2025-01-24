################################################################################
#                                                                              #
#                         ESTUDO BÁSICO DE R                                   #
#                         ÚLTIMA ATUALIZAÇÃO: 21 JAN 2025                      #
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
# Concatena elementos c()
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

# Objetos têm: nome
#              conteúdo
#              atributos: - mode: inteiro, numerico, caracter, complexo e lógico
#                         - length: nº de elementos

x <- 9
y <- c(3, 5, 6)
z <- "paulo"
# Um elemento caracter converte os outros em caracter!
a <- c(2, "lua", 8)  

mode(x); mode(y); mode(z); mode(a)

length(x); length(y); length(z)

# Cria um vetor numérico simples com 4 elementos
vector(mode = "numeric", length = 4) 
# Faz o mesmo que o comando acima
numeric(4)  

# Cria um vetor lógico simples com 4 elementos
vector(mode = "logical", length = 4) 
# Faz o mesmo que o comando acima
logical(4)  

# Cria um vetor de caracteres simples com 4 elementos
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

mat2 <- matrix(data = 1:9,
               nrow = 3,
               ncol = 3,
               dimnames = list(c("y1", "y2", "y3"), c("x1", "x2", "x3")))

t <- 1:3
d <- c("x1", "x2", "x3")
# Cria um dataframe
df <- data.frame(t, d)   

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

# Salvando arquivos no formato excel
library(writexl)

N <- 2500

# Criando o dataframe
my_df_A <- data.frame(y = seq(1:N), z = rep('a', N))

# Criando o arquivo
my_file <- paste0(getwd(), 'temp_write.xlsx')

# Salvando os dados num arquivo
write_xlsx(my_df_A, path = my_file)

# Verirficando a existência do arquivo
file.exists(my_file)

# Salvando e carregando arquivos nativos do R: .RData e .rds
save.image(file = "basico.RData")

load("basico.RData")

# Gravando os dados de um dataframe no arquivo 'dados.rds': 1 objeto por arquivo
saveRDS(my_df_A, "dados.rds")

# Lendo os dados de um arquivo .rds
df_rds <- readRDS("dados.rds")

# Gravando e lendo arquivos R no formatoo fts: maior velocidade de leitura e 
# gravação, sendo idel para grandes dataset
library(fst)

N <- 1000

my_df_B <- data.frame(x =runif(N))

write.fst(my_df_B, "dado.fst")

df_fst <- read.fst("dado.fst")

# Testando a velocidade degravação e leitura de arquivos .rds e .fst
N <- 2.5e8

my_df <- data.frame(y = 1:N, z = rep('a', N))

my_file_1 <- "dados.rds"
my_file_2 <- "dados.fst"

time_write_rds <- system.time(saveRDS(my_df, my_file_1))
time_write_fst <- system.time(write_fst(my_df, my_file_2))

time_read_rds <- system.time(readRDS(my_file_1))
time_read_fst <- system.time(read_fst(my_file_2))

file_size_rds <- file.size(my_file_1)/1000000
file_size_fst <- file.size(my_file_2)/1000000

my_formats <- c(".rds", ".fst")
results_read <- c(time_read_rds[3], time_read_fst[3])
results_write <- c(time_write_rds[3], time_write_fst[3])
results_file_size <- c(file_size_rds, file_size_fst)

my_text <- paste('\nTime to WRITE dataframe with', my_formats,
                      ':', results_write, 'seconds\n', collapse = '')
cat(my_text)

my_text <- paste('\nTime to READ dataframe with', my_formats,
                 ':', results_read, 'seconds\n', collapse = '')
cat(my_text)

my_text <- paste('\nResulting FILE SIZE', my_formats,
                 ':', results_file_size, 'MB\n', collapse = '')
cat(my_text)


# Lendo arquivo com o pacote 'readr'
library(readr)

# Lendo arquivo csv com sep = ',' e dec = '.'
oper <- read_csv("operacoes.csv",     
                   col_names = TRUE,
                   skip = 0)

# Lendao arquivo csv com sep = ';' e dec = ','
f_oper <- read_csv2("foperacoes.csv", 
                    col_names = TRUE,
                    skip = 0)

# Lendo arquivo csv com função geral (delim = ";" ou delim = ",")
f_oper <- read_delim("foperacoes.csv", 
                     delim = ";",
                     col_names = TRUE,
                     skip = 0)


my_cols <- cols(Ticker = col_character(), 
                Operacao = col_factor(c("COMPRA", "VENDA")), 
                Cotas = col_integer(), 
                Data = col_date(format = "%d/%m/%Y"), 
                Preco_Unitario = col_double(), 
                Preco_Total = col_double(), 
                Taxa_B3 = col_double(), 
                Taxa_CBLC = col_double(), 
                Outras_Despesas = col_double(), 
                Preco_Final = col_double(), 
                Subscricao = col_logical())

f_opr <- read_csv2("foperacoes.csv", 
                   skip = 0, 
                   col_select = Ticker:Subscricao, 
                   col_names = T, 
                   col_types = my_cols)

# Gravando arquivos no banco de dados SQLite
library(RSQLite)

N <- 1.0e6

my_large_df_1 <- data.frame(X = runif(N), 
                            G = sample(c('A', 'B'), 
                                       size = N, 
                                       replace = T))

my_large_df_2 <- data.frame(X = runif(N), 
                            G = sample(c('A', 'B'), 
                                       size = N, 
                                       replace = T))

my_con <- dbConnect(drv = SQLite(), "myDatabase.SQLITE")

dbWriteTable(conn = my_con, "myTable_1", value = my_large_df_1)
dbWriteTable(conn = my_con, "myTable_2", value = my_large_df_2)

dbDisconnect(my_con)

# Lendo dados do banco de dados SQLite


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

# Alterando os valores da matriz ou dataframe
apply(iris[, 1:4], 1:2, function(x) x + 2)

# FUNÇÃO lapply(): RECEBE VETOR, LISTA OU DATAFRAME E SEMPRE GERA UMA LISTA

r <- list(a = 1:10, b = 1:63, c = 52:73, d = 54:2)

# Calculando a média de cada elemento da lista
lapply(r, mean)

# Usando uma função personalizada
lapply(r, function(i){
    mean(i * 5)
})

# FUNÇÃO sapply(): FORMA SIMPLIFICADA DO lapply() - GERA UM VETOR PARA UM VETOR, 
#                  UMA LISTA PARA UMA LISTA E UMA MATRIZ PARA UM DATAFRAME

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

# FUNÇÃO mapply(): VERSÃO MULTIVARIADA DE sapply() - GERA UM VETOR

# As duas linhas de código a seguir produzem a mesma saída
mapply(rep, 1:4, 4:1)

list(rep(1,4), rep(2,3), rep(3,2), 4)

# Criando uma matriz
mapply(rep, 1:3, 4)

# Comparando vetores (elemento a elemento)
mapply(max, c(1, 3, 4, 5), c( 2, 4, 1, 9))

# Multiplicando elementos de dois vetores
mapply(function(e1, e2) e1 * e2, c(1, 3, 4, 5), c( 2, 4, 1, 9))

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

# FUNÇÃO subset() - subset(x, subset, select, drop = FALSE)

# Extraindo as operações do RZTR11 do conjunto de dados 'operacoes'
subset(
      x = operacoes,
      subset = Ticker == "RZTR11",
      select = c("Ticker", "Data da Operacao", "Nr Cotas", "Preco Total")
)

# Extraindo as operações entre datas
subset(
      operacoes,
      'Data da Operacao' >= "2024-12-01",
      c("Ticker", "Data da Operacao", "Preco Total")
)

# ARRAYS

# Diferenciando vetor de array
vv <- c(2, 4, 6, 4)  # vetor: não possui dimensão
is.vector(vv)  # TRUE
is.array(vv)   # FALSE

dim(vv) <- 4   # setando uma dimensão para vv
is.array(vv)   # TRUE

# Criando array
aa <- array(1:20, dim = c(4, 5))

ii <- array(c(1:3, 3:1), dim = c(3, 2))

yy <- array(1:9, dim = c(3, 3), dimnames = list(c("y1", "y2", "y3"), 
                                                c("x1", "x2", "x3")))
# Extraindo elementos de aa com a matriz de índice ii
aa[ii] # saída: 9 6 3

# Substituindo elementos por zero numa matriz
aa[ii] <- 0

# Calculando o produto externo de dois arrays (outer() ou %o%)
a1 <- array(1:4, dim = 4)
b1 <- array(5:8, dim = 4)

ab1 <- a1 %o% b1

ab2 <- outer(a1, b1, "*")  # ab1 = ab2

a2 <- array(1:4, dim = c(2, 2))
b2 <- array(5:8, dim = c(2, 2))

ab3 <- a2 %o% b2

# Permutando os índices de um array (transpondo um array)
A <- array(1:24, 2:4)  # vetor dimensão: 2 3 4

At <- aperm(A, c(2, 1, 3))  # indices do vetor dimensão: 2 1 3

# ALGEBRA MATRICIAL

# Criando matrizes (padrão por coluna)
M <- matrix(data = 3:11, nrow = 3, ncol = 3)

# Criando matrizes por linha
M_t <- matrix(data = 3:11, nrow = 3, ncol = 3, byrow = TRUE)

# Criando matrizes com cbind() e rbind()
A <- cbind(c(1, 3, 6), c(4, 5, 7), c(9, 4, 0))

A_t <- rbind(c(1, 3, 6), c(4, 5, 7), c(9, 4, 0))

# Inserindo linha e colunas em uma matriz
M_linha <- rbind(M, c(-2, 4,-8))

M_coluna <- cbind(M, c(-3, 4, 7))

# Alterando linhas e colunas em uma matriz
M_linha <- M_linha[c(4, 3, 2, 1),]

M_coluna <- M_coluna[,c(4, 2, 3, 1)]

# Nomeando linhas e colunas de umz matrix
M <- matrix(data = 3:11, nrow = 3, ncol = 3, dimnames = list(c("l1","l2","l3"), 
                                                             c("c1","c2","c3")))

# Criando matrizes com vetores
vec <- c(1, 7, 3, 4, 9, 11, 0, -1, 5, -4, 10)

M_vec <- matrix(vec, nrow = 3)

# Verificando se o objeto é uma matriz
is.matrix(M)

# Criando uma matrix nula
M_0 <- matrix(0, nrow = 3, ncol = 3)

# Acessando elementos de uma matriz
M[2, 3]  # linha 2 e coluna 3
M[, 2]   # todas as linha da coluna 2
M[1, ]   # todas as coluna da linha 1
M[, 2:3] # todas as linhas das colunas 2 e 3

# Criando uma matriz unitária
M_1 <- matrix(1, nrow = 3, ncol = 3)

# Criando uma matriz diagonal
M_diag <- diag(1:3, 3)

v <- c(8, -2, 4)
M_diag2 <- diag(v, 3)

# Extraindo a diagonal principal de uma matriz
dp <- diag(M_diag2)

# Alterando a diagonal principal de uma matrix
diag(M_diag) <- c(5, 2, 8)

# Criando uma matriz identidade
M_ide <- diag(1, 3)

# Somando e subtraindo matrizes
ss <- sample(1:99, 9, replace = TRUE)

M1 <- matrix(ss, nrow = 3, ncol = 3)

M2 <- matrix(round(ss/3), nrow = 3, ncol = 3)

M_soma <-  M1 + M2

M_subtracao <- M1 - M2

# Multiplicando por um escalar
k <- 6

M_prod <- M2 * k

# Multiplicação elemento a elemento (matrizes de mesma dimensão)
ifelse(dim(M1)  == dim(M2), M_prod_elem <- M1 * M2, 
       print("As matrizes não têm a mesma dimensão!"))

# Multiplicação matricial M3(n,m) x M4(m,p)
M3 <- matrix(data = sample(1:25, 8, replace = TRUE), nrow = 2)

M4 <- matrix(data = sample(1:35, 8, replace = TRUE), ncol = 2)

ifelse(dim(M3)[2] == dim(M4)[1], M_prod_mat <- M3 %*% M4, 
       print("As matrizes não têm dimensões compatíveis!"))

# Transpondo uma matriz
M1_t <- t(M1)

# Achando o determinando de uma matriz
det_M1 <- det(M1)

# Achando a matriz adjunta (matriz transposta dos cofatores)
library(matlib)

M_adjunta <- adjoint(M1)

# Invertendo uma matriz
cond1 <- dim(M1)[1] == dim(M1)[2] # ou nrow(M1) == ncol(M1)
cond2 <- det(M1) != 0

if(cond1 & cond2){
    M1_inv <- solve(M1)
} else {
    cat("A matriz não é inversível")
}

# Achando o traço de uma matriz
tr <- sum(diag(M1))

# Achando autovalores e autovetores de uma matriz simétrica
E <- eigen(M1)  # gera uma lista de dois componentes

# Autovalores (vetor)
E[1] # ou E$values

# Autovetores (matriz)
E[2] # ou E$vectores

# Achando apenas os autovalores
E_valores <- eigen(M1, only.values = TRUE)$values

# Resolvendo um sistema linear
A <- array(c(3, 2, 2, 3), dim = c(2, 2))
b <- c(6, 5)

x <- solve(A, b)
# x <- solve(A) %*% b: forma numericamente ineficiente e instavel!

# Decomposição em valores singulares: matriz retangular
R <- array(2:7, dim = c(3, 2))

dvs <- svd(R) # gera uma lista com três matrizes: matrizes colunas 
              # ortonormais 'u' e 'v' e uma matriz diagonal positiva 'd'
    
# INTERAGINDO COM ARQUIVOS DO S.O.

# Listando arquivos de um diretório
list.files(
           path = getwd(),
           full.names = T,
           include.dirs = T,
           all.files = T,
           recursive = T
)

# Listando arquivos usando expressão regular
list.files(path = getwd(),
           pattern = "*.RData$")

# Listando os diretórios
list.dirs(recursive = F)

# Apagando arquivos
meu_arquivo <- 'tempfile.csv'

write.csv(x = data.frame(x = 1:10), file = meu_arquivo)

file.remove(meu_arquivo) # dá um retorno TRUE/FALSE

# Apagando diretórios
dir.create('temp')

meu_arquivo <- 'temp/tempfile.csv'

write.csv(x = data.frame(x = 1:10), file = meu_arquivo)

unlink(x = 'temp', recursive = TRUE)

# Verificando a existência de um diretório
dir.exists('temp') # d´pa um retorno TRUE/FALSE

<<<<<<< HEAD
# Criando diretórios e arquivos temporários
temp_dir <- tempdir()

print(temp_dir)

temp_file <- tempfile()

print(temp_file)

# Baixando arquivos da internet
link <- 'https://github.com/douglas-dmc/R-Basico/blob/main/ativos.xlsx'

file.remove(tempfile())
local <- paste0(tempfile(), '.xlsx')

download.file(url = link, destfile = local)

library(readxl)

read_excel(path = local, col_names = T, skip = 0)
=======

>>>>>>> ffd48ea180486b5c977db6b4e6071ef80b2d255d
