

library(leaflet)

mapa <- leaflet(conteos_df) %>%
  fitBounds(-122.19, 12.1, -84.64, 32.72) %>% addTiles() %>%
  addMarkers(lng = ~as.numeric(longitud), lat = ~as.numeric(latitud), popup =~pop_up)
mapa
