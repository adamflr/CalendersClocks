# From points to grid/polygon
library(sf)
library(dplyr)
library(purrr)
library(tidyr)
library(ggplot2)
library(magrittr)

# Create points and polygons
points <- st_multipoint(as.matrix(expand.grid(seq(0.5,4.5,1), seq(0.5,4.5,1))))

pol <- st_polygon(list(matrix(c(0,0,4,4,0,4,0,0), byrow = T, ncol = 2)))
pol2 <- st_polygon(list(matrix(c(0,0,0,4,4,0,0,0), byrow = T, ncol = 2)))

# Illustrate use of st_intersection()
st_intersection(pol, pol2) %>% plot()

# st_coordinates(points)[1, 1:2] + matrix(c(-0.5,-0.5,0.5,-0.5,0.5,0.5,-0.5,0.5,-0.5,-0.5), byrow = T, ncol = 2)

# map and unnest to create longer sets
foo <- function(x) c(x-3, x, x+3)
data.frame(x = letters[1:5]) %>% 
  mutate(y = 3, d = map(y, foo)) %>% 
  unnest(cols = c(d))

# Square-making function
foo <- function(x, y) matrix(c(x, y), 5, 2, byrow = T) + matrix(c(-0.5,-0.5,0.5,-0.5,0.5,0.5,-0.5,0.5,-0.5,-0.5), byrow = T, ncol = 2)
foo(1.5, 3.5)

# st_make_grid?
dat <- st_coordinates(points)[,1:2] %>% as.data.frame()
dat$id <- 1:25

dat_sp <- st_as_sf(dat, coords = c("X", "Y")) # Already had points
dat_grid <- st_make_grid(dat_sp, cellsize = 1, n = c(5,5)) # Can be done without a spatial reference

dt <- data.frame(x1 = 1:25, x2 = 2:26)
st_geometry(dt) <- dat_grid # Set geometry from grid, keep the variables. Requires same order

dat_int <- st_intersection(dt, pol) # Do the intersection

ggplot(dat_int) + geom_sf(aes(fill = x1))
dat_int %>% 
  mutate(indicator = st_is(geometry, "POINT")) %>% 
  filter(!indicator) -> dat_temp # Filter out single points

ggplot(dat_temp) + 
  geom_sf(fill = rgb(dat_temp$x1 / max(dat_temp$x1), 0.5, 0.3), col = NA)
