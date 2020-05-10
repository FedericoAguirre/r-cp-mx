# Autor: Federico Aguirre
# Paypal: https://paypal.me/FAguirreCardiel
# Correo: federico.aguirre.cardiel@gmail.com
# LinkedIn: https://www.linkedin.com/in/federicoaguirrec
# Blog: http://programandochacharas.blogspot.com
# Twitter: https://twitter.com/FAguirreCardiel
# Github: https://github.com/FedericoAguirre

library(dplyr)
library(tidyr)
library(ggplot2)
library(leaflet)

setwd("/Users/federicoaguirre/Documents/proyectos/r-cp-mx/")

genera_kpis <- function (estado, infectados, muertos, descartados,
  sospechosos) {
  tabla_encabezado <- paste("<table style=\"font:normal 14px Roboto,Sans-serif;border:solid 5px #586670;border-radius:5px 5px 5px 5px;padding:5px;background-color:#e6e8e6\">", "", sep = "")
  fila_estado <- paste("<tr style=\"font-weight:bold; font-size:1.2et\"><td colspan=\"2\">", estado, "</td></tr>", sep = "")
  fila_infectados <- paste("<tr><td style=\"color:#f00000\">Infectados</td><td style=\"text-align:right\">", formatC(infectados, big.mark = ","), "</td></tr>", sep = "")
  fila_muertos<- paste("<tr><td style=\"color:#000000\">Muertos</td><td style=\"text-align:right\">", formatC(muertos, big.mark = ","), "</td></tr>", sep = "")
  fila_descartados <- paste("<tr><td style=\"color:#e2aa61\">Sospechosos</td><td style=\"text-align:right\">", formatC(descartados, big.mark = ","), "</td></tr>", sep = "")
  fila_sospechosos <- paste("<tr><td style=\"color:#87949b\">Descartados</td><td style=\"text-align:right\">", formatC(sospechosos, big.mark = ","), "</td></tr>", sep = "")
  tabla_pie <- "</table>"
  tabla <- paste(tabla_encabezado, fila_estado, fila_infectados, fila_muertos,
  fila_descartados, fila_sospechosos, tabla_pie, sep = "")
  return(tabla)
}

covid_raw_df <- read.csv("cp-db/200501COVID19MEXICO.csv", header = TRUE, sep = ",",
  skip = 0, colClasses = "character", na.strings = "NA")

geoposicion_df <- read.csv("./cp-db/estado_geoposicion.csv" , header = TRUE, sep = ",",
                           skip = 0, colClasses = "character", na.strings = "NA")

#duplicados_df <- select(covid_raw_df, ID_REGISTRO) %>%
#  group_by(ID_REGISTRO) %>% summarise(duplicados = n()) %>%
#  filter(duplicados > 1)

conteo_resultado_df <- select(covid_raw_df, RESULTADO) %>%
    group_by(RESULTADO) %>% summarise(conteo = n())

#infectados_df <- filter(covid_raw_df, RESULTADO == "1")
#muertos_df <- filter(covid_raw_df, RESULTADO == "1" & FECHA_DEF != "9999-99-99")
#descartados_df <- filter(covid_raw_df, RESULTADO == "2")
#sospechosos_df <- filter(covid_raw_df, RESULTADO == "3")

#sospechosos_muertos_df <- filter(covid_raw_df, RESULTADO == "3" & FECHA_DEF != "9999-99-99")
#descartados_muertos_df <- filter(covid_raw_df, RESULTADO == "2" & FECHA_DEF != "9999-99-99")


banderas_df <- select(covid_raw_df, ID_REGISTRO, RESULTADO, FECHA_DEF, ENTIDAD_RES) %>%
  mutate(
    infectado = ifelse(RESULTADO == "1", 1, 0 ),
    muerto = ifelse(FECHA_DEF != "9999-99-99" & RESULTADO == "1", 1, 0 ),
    descartado = ifelse(RESULTADO == "2", 1, 0 ),
    sospechoso = ifelse(RESULTADO == "3", 1, 0 )
  )

conteos_covid_df <- select(banderas_df, estado_id = ENTIDAD_RES, infectado, muerto,
  descartado, sospechoso) %>% group_by(estado_id) %>%
  summarise(
    infectados = sum(infectado),
    muertos = sum(muerto),
    descartados = sum(descartado),
    sospechosos = sum(sospechoso)) %>%
  inner_join(geoposicion_df, by = "estado_id", copy = FALSE, keep = TRUE) %>%
  mutate(kpis = genera_kpis(estado, infectados, muertos, descartados,
    sospechosos))

barras_infectados <- ggplot(data=conteos_covid_df, aes(x=reorder(estado, -infectados), y=infectados)) +
      labs(title = "INFECTADOS COVID 19") +
      xlab("Estados") +
      ylab("Infectados") +
      geom_bar(stat="sum", fill = "steelblue") +
      geom_text(aes(label=infectados), angle = 45) +
      theme(axis.text.x = element_text(angle = 90, hjust = 1), axis.text.y = element_text(angle = 90, hjust = 1))
barras_infectados

mapa <- leaflet(conteos_covid_df) %>%
  fitBounds(-122.19, 12.1, -84.64, 32.72) %>% addTiles() %>%
  addMarkers(lng = ~as.numeric(longitud), lat = ~as.numeric(latitud), popup =~kpis)
mapa
