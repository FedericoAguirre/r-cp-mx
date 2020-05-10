# Autor: Federico Aguirre
# Paypal: https://paypal.me/FAguirreCardiel
# Correo: federico.aguirre.cardiel@gmail.com
# LinkedIn: https://www.linkedin.com/in/federicoaguirrec
# Blog: http://programandochacharas.blogspot.com
# Twitter: https://twitter.com/FAguirreCardiel
# Github: https://github.com/FedericoAguirre

library(leaflet)

mapa <- leaflet(conteos_df) %>%
  fitBounds(-122.19, 12.1, -84.64, 32.72) %>% addTiles() %>%
  addMarkers(lng = ~as.numeric(longitud), lat = ~as.numeric(latitud), popup =~pop_up)
mapa
