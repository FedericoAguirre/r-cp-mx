# Datos descargados de Correos mexicanos:
# https://www.correosdemexico.gob.mx/SSLServicios/ConsultaCP/CodigoPostal_Exportar.aspx

library(dplyr)

cp_df <- read.csv("~/Downloads/CPdescarga.txt" , header = TRUE, sep = "|",
  skip = 1, colClasses = "character", na.strings = "NA", encoding = "latin1")

zona_df <- select(cp_df, zona = d_zona) %>% distinct()

zona_df <- mutate(zona_df, zona_id = substring(zona, 0, 1)) %>%
  select(zona_id, zona)

estado_df <- select(cp_df, estado_id = c_estado, estado = d_estado) %>%
distinct()

tipo_asentamiento_df <- select(cp_df, tipo_asentamiento_id = c_tipo_asenta,
  tipo_asentamiento = d_tipo_asenta) %>% distinct()

# Se filtró el campo de c_cve_ciudad porque las zonas rurales, ejidos, granjas,
# etc. no clasifican como ciudad

ciudad_df <- filter(cp_df, c_cve_ciudad != "") %>% select(estado_id = c_estado,
  ciudad_id = c_cve_ciudad, ciudad = d_ciudad) %>% distinct()

municipio_df <- select(cp_df, estado_id = c_estado, municipio_id = c_mnpio,
  municipio = D_mnpio) %>% distinct()
