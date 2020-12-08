### Making Cartograms in R

##Partial source: https://www.r-graph-gallery.com/331-basic-cartogram.html

library(cartogram)
library(maptools)
library(tidyverse)
library(broom)
library(rgeos)
library(sf)

sf_data <- st_read("SF_data_new.shp")

ggplot() +
  geom_sf(data = sf_data, color = "black", size = 0.5, fill = "white") +
  ggtitle("Map of SF") +
  coord_sf() + theme_bw()

sf_data_proj <- sf::st_transform(sf_data, 3857) #projecting the data
# construct a cartogram using the mental health variable
sf_cartogram <- cartogram_cont(sf_data_proj, "sfMental_h", itermax=10)
#sf_cartogram <- cartogram_cont(sf_data_proj, "sfCoronary", itermax=10) #Another option with a different variable


par(mfrow=c(1,2)) #Setting it to show two plots side-by-side
plot(sf_data["NAME10"], main = "Original", reset = FALSE)
plot(sf_cartogram["NAME10"], main = "Cartogram", reset = FALSE)

