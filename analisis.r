library(dplyr)
library(tidyr)

setwd("/Users/federicoaguirre/Documents/proyectos/r-cp-mx/")

genera_popup <- function (estado, urbano, semiurbano, rural) {
  tabla_encabezado <- paste("<table><tr><th colspan=\"2\"><b>", estado, "</b></th></tr>", sep = "")
  fila_urbano <- paste("<tr><td>Urbano</td><td>", urbano, "</td></tr>", sep = "")
  fila_semiurbano <- paste("<tr><td>Semiurbano</td><td>", semiurbano, "</td></tr>", sep = "")
  fila_rural <- paste("<tr><td>Rural</td><td>", rural, "</td></tr>", sep = "")
  tabla_pie <- "</table>"
  tabla <- paste(tabla_encabezado, fila_urbano, fila_semiurbano, fila_rural, tabla_pie, sep = "")
  return(tabla)
}

zona_df <- read.csv("./cp-db/zona.csv" , header = TRUE, sep = ",",
  skip = 0, colClasses = "character", na.strings = "NA")

asentamiento_df <- read.csv("./cp-db/asentamiento.csv" , header = TRUE, sep = ",",
  skip = 0, colClasses = "character", na.strings = "NA")

geoposicion_df <- read.csv("./cp-db/estado_geoposicion.csv" , header = TRUE, sep = ",",
                            skip = 0, colClasses = "character", na.strings = "NA")

conteo_asentamiento_df <- crossing(geoposicion_df, zona_df) %>%
  left_join(asentamiento_df, by = c("estado_id", "zona_id"), copy = FALSE, keep = TRUE) %>%
  mutate(tiene_asentamiento = ifelse(is.na(asentamiento), 0, 1 ))  %>%
  select(estado_id, estado, latitud, longitud, zona_id, zona, tiene_asentamiento) %>%
  group_by(estado_id, estado, latitud, longitud, zona_id, zona) %>%
  summarise(asentamientos = sum(tiene_asentamiento)) %>%
  mutate(pop_up = paste('<div><div><b>', estado, '</b></div><div>', asentamientos, '</div></div>'))

asentamiento_urbano_df <- filter(conteo_asentamiento_df, zona_id == 'U')
asentamiento_semiurbano_df <- filter(conteo_asentamiento_df, zona_id == 'S')
asentamiento_rural_df <- filter(conteo_asentamiento_df, zona_id == 'R')

conteos_df <- select(conteo_asentamiento_df, estado, latitud, longitud, zona, asentamientos) %>%
  spread(zona, asentamientos) %>%
  group_by(estado, latitud, longitud) %>%
  summarise(urbanos = sum(coalesce(Urbano,0)), semiurbanos = sum(coalesce(Semiurbano,0)), rurales = sum(coalesce(Rural,0))) %>%
  mutate(pop_up = genera_popup(estado, urbanos, semiurbanos, rurales))
