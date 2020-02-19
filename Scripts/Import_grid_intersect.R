# Import as image, transform to sf, keep color data, make grid in sf, plot
# Packages ----
library(dplyr)
library(rgdal)
library(sf)
library(ggplot2)
library(cowplot)

# Import image ----
img_path <- "Example pictures/Kurre6.jpg"
img <- readGDAL(img_path)

img_sf <- st_as_sf(img) # Point geometry. Order is x, then decreasing y
img_grid <- st_make_grid(img_sf, cellsize = 1) # Order is x, then increasing y

dt <- expand.grid(x = 1:st_bbox(img_grid)$xmax, y = 1:st_bbox(img_grid)$ymax)
st_geometry(dt) <- img_grid
dt %>% arrange(desc(y), x) -> dt

st_geometry(img_sf) <- st_geometry(dt)

g1 <- ggplot(img_sf) + 
  geom_sf(fill = rgb(img_sf$band1/360, img_sf$band2/360, img_sf$band3/360), col = NA)

# Circle
sp_circle <- data.frame(co = exp(1i * seq(0, 2*pi, length.out = 360))) %>% 
  mutate(x = Re(co), y = Im(co))
sp_circle[dim(sp_circle)[1],] <- sp_circle[1,]
sp_pol <- st_polygon(list(as.matrix(sp_circle[,2:3])))
bb <- st_bbox(img_sf)
sp_pol <- sp_pol * bb$xmax/3 + t(t(c(bb$xmax/2, bb$ymax/2)))

g2 <- ggplot(sp_pol) + geom_sf() + xlim(0, bb$xmax) + ylim(0, bb$ymax)

st_intersection(img_sf, sp_pol) %>% 
  filter(!st_is(geometry, "POINT")) -> img_sf_int

img_sf_int %>% 
  mutate_at(vars(band1, band2, band3), function(x) x/360) -> img_sf_int
g3 <- ggplot(img_sf_int) + 
  geom_sf(fill = rgb(img_sf_int$band1, img_sf_int$band2, img_sf_int$band3),
          col = NA) +
  xlim(0, bb$xmax) + ylim(0, bb$ymax)

library(patchwork)
g4 <- g1 / g2 | g3
ggsave("Output/Intersecting_squirrel2.png", g4, width = 8, height = 5.5)
