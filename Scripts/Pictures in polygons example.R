# Picture in polygon example
# Packages ----
library(raster)
library(dplyr)
library(rgdal)
library(sp)
library(magrittr)

# Import (jpeg) picture ----
img_path <- "Example pictures/Kurre5.jpg"
img <- readGDAL(img_path)
class(img)
SpatialPolygons(img)
img_ra <- raster(img)
extent(img_ra) <- extent(c(0,1,0,1))
img_sp <- rasterToPolygons(img_ra)

# Construct polygon in [0,1] x [0,1] as spatial object ----
dat_po <- data.frame(x = c(0,0.1,0.5,0.8,1,0)*300,
                     y = c(0,0.5,1,0.4,0,0)*300)

sp_po <- Polygon(dat_po)
sp_po <- Polygons(list(sp_po), "sp1")
sp_po <- SpatialPolygons(list(sp_po))

# Intersect raster and polygon
raster::intersect(img_sp, sp_po) %>% plot()
plot(sp_po)

# Over?
dat <- cbind(expand.grid(x = 1:extent(img)[2], y = extent(img)[4]:1), img@data)
dat$include <- over(img, sp_po)
dat %>% 
  filter(!is.na(dat$include)) -> dat_t 
ggplot(dat_t, aes(x, y)) + 
  geom_point(col = rgb(dat_t$band1/360, dat_t$band2/360, dat_t$band3/360)) +
  geom_path(data = dat_po, size = 5)
