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
img_path <- "Example pictures/Kurre5.jpg"
img <- readGDAL(img_path)
img@data <- cbind(data.frame(id = 1:dim(img@data)[1]), img@data)
# class(img)
# SpatialPolygons(img) # Error, not list
img_ra <- raster(img)
extent(img_ra) <- extent(c(0,1,0,1))
img_sp <- rasterToPolygons(img_ra)
img_sp@data <- img@data

# Construct polygon in [0,1] x [0,1] as spatial object ----
dat_po <- data.frame(x = c(0,0.1,0.5,0.8,1,0),
                     y = c(0,0.5,1,0.4,0,0))

#st_po <- st_polygon(list(as.matrix(dat_po))) %>% plot()

# sp_po <- Polygon(dat_po)
# sp_po <- Polygons(list(sp_po), "sp1")
# sp_po <- SpatialPolygons(list(sp_po))

# Intersect raster and polygon ----
raster::intersect(img_sp, sp_po) -> sp_int
dt_sf <- st_as_sf(sp_int)

ggplot() + 
  geom_sf(data = dt_sf, fill = rgb(dt_sf$band1/360, dt_sf$band3/360, dt_sf$band3/360), col = NA, alpha = 1)

# Over? ----
dat <- cbind(expand.grid(x = 1:extent(img)[2], y = extent(img)[4]:1), img@data)
dat$include <- over(img, sp_po)

dat %>% 
  filter(!is.na(dat$include)) -> dat_t 

g1 <- ggplot(dat_t, aes(x, y)) + 
  geom_point(col = rgb(dat_t$band1/360, dat_t$band2/360, dat_t$band3/360)) +
  coord_equal()

g2 <- ggplot(dat_t, aes(xmin = x, xmax = x + 1, ymin = y, ymax = y + 1)) +
  geom_rect(fill = rgb(dat_t$band1/360, dat_t$band2/360, dat_t$band3/360)) + 
  ylab("y") + xlab("x") +
  coord_equal()

gridExtra::grid.arrange(g1, g2, ncol = 2)
