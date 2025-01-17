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
# hwy          : autonomia na estrada (milhas por galão)
# fl           : tipo de combutivel
# class        : tipo de carro          

# Plotando gráfico de pontos (displ x hwy)
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, color = class))

# Plotando gráfico de dispersão (hwy x cyl)
ggplot(data = mpg) +
    geom_point(mapping = aes(x = hwy, y = cyl))
