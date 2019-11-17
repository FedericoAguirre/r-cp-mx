# Datos descargados de Correos mexicanos:
# https://www.correosdemexico.gob.mx/SSLServicios/ConsultaCP/CodigoPostal_Exportar.aspx

library(dplyr)

# Cambiar el directorio como sea requerido
setwd("/Users/federicoaguirre/Documents/proyectos/r-cp-mx/")

cp_raw_df <- read.csv("./cp-mx/CPdescarga.txt" , header = TRUE, sep = "|",
  skip = 1, colClasses = "character", na.strings = "NA", encoding = "latin1")

zona_df <- select(cp_raw_df, zona = d_zona) %>% distinct()

zona_df <- mutate(zona_df, zona_id = substring(zona, 0, 1)) %>%
  select(zona_id, zona)

estado_df <- select(cp_raw_df, estado_id = c_estado, estado = d_estado) %>%
distinct()

tipo_asentamiento_df <- select(cp_raw_df, tipo_asentamiento_id = c_tipo_asenta,
  tipo_asentamiento = d_tipo_asenta) %>% distinct()

# Se filtró el campo de c_cve_ciudad porque las zonas rurales, ejidos, granjas,
# etc. no clasifican como ciudad

ciudad_df <- filter(cp_raw_df, c_cve_ciudad != "") %>% select(estado_id = c_estado,
  ciudad_id = c_cve_ciudad, ciudad = d_ciudad) %>% distinct()

municipio_df <- select(cp_raw_df, estado_id = c_estado, municipio_id = c_mnpio,
  municipio = D_mnpio) %>% distinct()

asentamiento_df <- select(cp_raw_df, oficina = c_oficina, codigo_postal = d_codigo,
  asentamiento = d_asenta, tipo_asentamiento_id = c_tipo_asenta,
  estado_id = c_estado, municipio_id = c_mnpio, ciudad_id = c_cve_ciudad,
  zona = d_zona) %>% mutate(zona_id = substring(zona, 0, 1))

# Remueve columna zona
asentamiento_df$zona <- NULL

write.csv(zona_df, file = "./cp-db/zona.csv", row.names = FALSE)
write.csv(tipo_asentamiento_df, file = "./cp-db/tipo_asentamiento.csv", row.names = FALSE)
write.csv(estado_df, file = "./cp-db/estado.csv", row.names = FALSE)
write.csv(municipio_df, file = "./cp-db/municipio.csv", row.names = FALSE)
write.csv(ciudad_df, file = "./cp-db/ciudad.csv", row.names = FALSE)
write.csv(asentamiento_df, file = "./cp-db/asentamiento.csv", row.names = FALSE)
