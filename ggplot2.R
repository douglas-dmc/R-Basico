################################################################################
#                                                                              #
#                         ESTUDO BÁSICO DE ggplot2                             #
#                         ÚLTIMA ATUALIZAÇÃO: 17 JAN 2025                      #
#                                                                              #
################################################################################

# Carregando pacote
library(tidyverse)

# Carregando o dataframe mpg
data(mpg)

# Visualizando a estrutura do mpg
str(mpg)

# Entendendo o dataframe mpg
?mpg

# manufactorer : fabricante
# displ        : capacidade do motor em litros
# year         : ano de fabricação
# cyl          : numero de cilindros
# trans        : tipo de transmissão
# drv          : tipo de trem de força, onde f = tração dianteira, 
#                                            r = tração traseira, 4 = 4x4
# cty          : autonomia na cidade (milhas por galão)
# hwy          : autonomia na estrada (milhas por galão)
# fl           : tipo de combutivel
# class        : tipo de carro          

# Plotando gráfico de pontos (displ x hwy)
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, color = class))

# Definindo manualmente a cor dos pontos (displ x hwy)
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy), color = "dodgerblue")

# Definindo condicionalmente a cor dos pontos (displ x hwy)
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, color = displ < 5))

# Plotando gráfico de dispersão (hwy x cyl)
ggplot(data = mpg) +
    geom_point(mapping = aes(x = hwy, y = cyl, shape = fl))
    # shape só pode ser usado em variáveis categóricas
    
# Separando um gráfico com uma variável categórica
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy), size = 3, color = "blue") +
    facet_wrap(~ class, nrow = 2)

# Plotando o gráfico em uma grade com 2 variáveis categóricas
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, color = class)) +
    facet_grid(drv ~ cyl) # as variáveis devem ser categóricas

# Plotando gráficos em uma grade com uma variável categórica
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy)) +
    facet_grid(. ~ cyl)

ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy)) +
    facet_grid(drv ~ .)

# Plotando gráfico de linhas
ggplot(data = mpg) +
    geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

ggplot(data = mpg) +
    geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))

ggplot(data = mpg) +
    geom_smooth(mapping = aes(x = displ, y = hwy, color = drv))

# Plotando multiplas linhas de dados num mesmo gráfico
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point(mapping = aes(color = class)) +
    geom_smooth()

# Plotando diferentes dados num mesmo gráfico
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point(mapping = aes(colour = class)) +
    geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)

# Carregando o dataframe diamonds
data("diamonds")

# Visualizando a estrutura do df diamonds
str(diamonds)

# Obtendo informações do df diamonds
?diamonds

# price   : preço
# carat   : peso (0.2 - 5.01)
# cut     : qualidade do corte (Fair, Good, Vey Goog, Premium, Ideal)
# color   : cor (D (melhor) até J (pior))
# clarity : clareza (I1 (pior), SI2, SI1, VS2, VS1, VVS2, VVS1, IF (melhor))
# x       : comprimento (mm)
# y       : largura (mm)
# z       : profundidade (mm)
# depth   : percentual total de profundidade = z / mean(x, y)
# table   : largura do topo do diamante relativo ao ponto mais largo (43 - 95)

# Plotando o gráfico de barras da variável cut (stat = count)
ggplot(data = diamonds) +
    geom_bar(mapping = aes(x = cut))

# Plotando o gráfico de barras da variável cut (y = prop)
ggplot(data = diamonds) +
    geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1), width = .6)
    
# Realizando a mesma coisa que o código anterior
    ggplot(data = diamonds) +
geom_bar(mapping = aes(x = cut, y = after_stat(count/sum(count))), width = .6)

# Plotando um resumo dos valores de y para cada valor de x
ggplot(data = diamonds) +
    stat_summary(mapping = aes(x = cut, y = depth),
                 fun.ymin = min,
                 fun.ymax = max,
                 fun.y = median)

# Plotando gráficos de barra coloridos
ggplot(data = diamonds) +
    geom_bar(mapping = aes(x = cut, colour = cut))  # contornos das barras

ggplot(data = diamonds) +
    geom_bar(mapping = aes(x = cut, fill = cut))    # preenchimento das barras

ggplot(data = diamonds) +
    geom_bar(mapping = aes(x = cut, fill = clarity))

ggplot(data = diamonds) +
    geom_bar(mapping = aes(x = cut, fill = clarity), 
             alpha = 1/5, position = "identity")

ggplot(data = diamonds) +
    geom_bar(mapping = aes(x = cut, colour = clarity), 
             fill = NA, position = "identity")

ggplot(data = diamonds) +
    geom_bar(mapping = aes(x = cut, fill = clarity), # facilita a comparação
             position = "fill")   

ggplot(data = diamonds) +
    geom_bar(mapping = aes(x = cut, fill = clarity), # facilita a comparação
             position = "dodge2", padding = 0.4)

# Faz o mesmo q o código anterior e inverte as barras
ggplot(data = diamonds) +
    geom_bar(mapping = aes(x = cut, fill = clarity), 
             position = position_dodge2(padding = 0.2, reverse = T))
