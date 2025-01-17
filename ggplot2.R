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

# Plotando gráfico de pontos (displ x hwy)
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy))
