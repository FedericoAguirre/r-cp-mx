library(ggplot2)

barras_urbanos<-ggplot(data=asentamiento_urbano_df, aes(x=reorder(estado, -asentamientos), y=asentamientos)) +
  labs(title = "ASENTAMIENTOS URBANOS") +
  xlab("Estados") +
  ylab("Asentamientos") +
  geom_bar(stat="sum", fill = "steelblue") +
  geom_text(aes(label=asentamientos), angle = 45) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1), axis.text.y = element_text(angle = 90, hjust = 1))
barras_urbanos

barras_semiurbanos<-ggplot(data=asentamiento_semiurbano_df, aes(x=reorder(estado, -asentamientos), y=asentamientos)) +
  labs(title = "ASENTAMIENTOS SEMIURBANOS") +
  xlab("Estados") +
  ylab("Asentamientos") +
  geom_bar(stat="sum", fill = "steelblue") +
  geom_text(aes(label=asentamientos), angle = 45) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1), axis.text.y = element_text(angle = 90, hjust = 1))
barras_semiurbanos

barras_rurales<-ggplot(data=asentamiento_semiurbano_df, aes(x=reorder(estado, -asentamientos), y=asentamientos)) +
  labs(title = "ASENTAMIENTOS RURALES") +
  xlab("Estados") +
  ylab("Asentamientos") +
  geom_bar(stat="sum", fill = "steelblue") +
  geom_text(aes(label=asentamientos), angle = 45) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1), axis.text.y = element_text(angle = 90, hjust = 1))
barras_rurales
