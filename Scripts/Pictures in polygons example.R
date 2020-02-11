# Picture in polygon example
# Packages ----
library(raster)
library(dplyr)
library(rgdal)
library(sp)
library(magrittr)
library(ggplot2)

# Import (jpeg) picture ----
img_path <- "Example pictures/Kurre5.jpg"
img <- readGDAL(img_path)
# class(img)
# SpatialPolygons(img) # Error, not list
img_ra <- raster(img)
extent(img_ra) <- extent(c(0,1,0,1))
img_sp <- rasterToPolygons(img_ra)

# Construct polygon in [0,1] x [0,1] as spatial object ----
dat_po <- data.frame(x = c(0,0.1,0.5,0.8,1,0)*300,
                     y = c(0,0.5,1,0.4,0,0)*300)

sp_po <- Polygon(dat_po)
sp_po <- Polygons(list(sp_po), "sp1")
sp_po <- SpatialPolygons(list(sp_po))

# Intersect raster and polygon ----
# raster::intersect(img_sp, sp_po) %>% plot()
# plot(sp_po)
raster::intersect(img_sp, sp_po) -> sp_int
# plot(sp_int)
unlist(lapply(sp_int@polygons, function(x) x@labpt)) -> a
da <- data.frame(x = a[seq(1, 262368,2)], y = a[seq(2, 262368,2)], ba = sp_int$band1)
ggplot(da, aes(x, y)) + geom_point(col = rgb(da$ba/360, 0, 0)) + coord_equal() # Does not follow the polygon (?)

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
