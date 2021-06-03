library(dplyr)
library(ggplot2)

# Question 2 answer chart
question2 <- read.csv("/Users/Amanda/Documents/Repositorios/ADS-Lab2/out/out-03_33_40-2021-06-03/atv2-results-tcm.csv")
ggplot(question2) + 
  aes (x = TaxaDeChegadaMedia, y = TempoMedioDeResposta) + 
  geom_line(col="#030CE6", lwd=1) +
  labs(x="Average arrival rate",
       y="Average response time",
       title = "Question 2. Response time variation by arrival rate")


# Question 3 answer chart
question3 <- read.csv("/Users/Amanda/Documents/Repositorios/ADS-Lab2/out/out-15_09_38-2021-06-03/atv2-results-numS.csv")
ggplot(question3) + 
  aes (x = NumServidores, y = TempoMedioDeResposta) + 
  geom_line(col="#030CE6", lwd=1) +
  labs(x="Number of servers",
       y="Average response time",
       title = "Question 3. Response time variation by number of servers")




# Question 4 answer chart
question4 <- read.csv("/Users/Amanda/Documents/Repositorios/ADS-Lab2/out/out-12_28_21-2021-06-03/atv2-results-tcm.csv")
ggplot(question4) + 
  aes (x = TaxaDeChegadaMedia, y = TempoMedioDeResposta) + 
  geom_line(col="#030CE6", lwd=1) +
  labs(x="TaxaDeChegadaMedia",
       y="TempoMedioDeResposta",
       title = "Question 4. Average response time per arrival rate")


