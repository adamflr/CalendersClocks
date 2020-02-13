# Picture in polygon example
# Packages ----
library(raster)
library(dplyr)
library(rgdal)
library(sp)
library(sf)
library(magrittr)
library(ggplot2)

# Import (jpeg) picture ----
img_path <- "Example pictures/Kurre6.jpg"
img <- readGDAL(img_path)

img_sf <- st_as_sf(img)
img_sf <- img_sf %>% mutate(geometry = geometry / matrix(st_bbox(img_sf)[3:4], 1))

g1 <- ggplot() + 
  geom_sf(data =img_sf, col = rgb(img_sf$band1/360, img_sf$band2/360, img_sf$band3/360), size = 3)

g1

# Construct polygon in [0,1] x [0,1] as spatial object ----
dat_po <- data.frame(x = c(0,0.1,0.5,0.8,1,0), y = c(0,0.5,1,0.4,0,0))

st_po <- st_polygon(list(as.matrix(dat_po)))

g2 <- ggplot() + geom_sf(data = st_po, size = 3)
g2

# Intersect raster and polygon ----
img_int <- sf::st_intersection(img_sf, st_po) # Same effect as previous use of over (i.e. still points)
plot(img_int)

# raster::intersect(img_sp, st_po) -> sp_int
# dt_sf <- st_as_sf(sp_int)

g3 <- ggplot() + 
  geom_sf(data = img_int, col = rgb(img_int$band1/360, img_int$band3/360, img_int$band3/360), alpha = 1, size = 3)
g3

gridExtra::grid.arrange(g1, g2, g3, ncol = 3)
