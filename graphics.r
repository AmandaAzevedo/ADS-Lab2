library(dplyr)
library(ggplot2)

question2 <- read.csv("/Users/Amanda/Downloads/ADS-Lab2/ADS-Lab2-master/out/out-03_33_40-2021-06-03/atv2-results-tcm.csv")
ggplot(question2) + 
  aes (x = TaxaDeChegadaMedia, y = TempoMedioDeResposta) + 
  geom_line(col="#030CE6", lwd=1) +
  labs(x="Taxa de chegada média",
       y="Tempo médio de resposta",
       title = "Questão 2. Variação do tempo de resposta")



question3 <- read.csv("/Users/Amanda/Downloads/ADS-Lab2/ADS-Lab2-master/out/out-03_47_23-2021-06-03/atv2-results-numS.csv")
ggplot(question3) + 
  aes (x = NumServidores, y = TempoMedioDeResposta) + 
  geom_line(col="#030CE6", lwd=1) +
  labs(x="Número de servidores",
       y="Tempo médio de resposta",
       title = "Questão 3. Variação do número de servidores por tempo médio de resposta")