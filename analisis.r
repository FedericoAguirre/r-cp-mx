library(dplyr)

setwd("/Users/federicoaguirre/Documents/proyectos/r-cp-mx/")

zona_df <- read.csv("./cp-db/zona.csv" , header = TRUE, sep = ",",
  skip = 0, colClasses = "character", na.strings = "NA")

estado_df <- read.csv("./cp-db/estado.csv" , header = TRUE, sep = ",",
  skip = 0, colClasses = "character", na.strings = "NA")

asentamiento_df <- read.csv("./cp-db/asentamiento.csv" , header = TRUE, sep = ",",
  skip = 0, colClasses = "character", na.strings = "NA")


# se usa n() porque no se puede contabilizar variables "character"
# o datos cualitativos
conteo_asentamiento_df <- select(asentamiento_df, asentamiento, estado_id,
  zona_id) %>%
  group_by(estado_id, zona_id) %>%
  summarise(asentamientos = n())

asentamiento_urbano_df <- filter(conteo_asentamiento_df, zona_id == 'U') %>%
  inner_join(estado_df, by = "estado_id", copy = FALSE, keep = TRUE) %>%
  inner_join(zona_df, by = "zona_id", copy = FALSE, keep = TRUE)

asentamiento_semiurbano_df <- filter(conteo_asentamiento_df, zona_id == 'S') %>%
  inner_join(estado_df, by = "estado_id", copy = FALSE, keep = TRUE) %>%
  inner_join(zona_df, by = "zona_id", copy = FALSE, keep = TRUE)

asentamiento_rural_df <- filter(conteo_asentamiento_df, zona_id == 'R') %>%
  inner_join(estado_df, by = "estado_id", copy = FALSE, keep = TRUE) %>%
  inner_join(zona_df, by = "zona_id", copy = FALSE, keep = TRUE)
