# From points to grid/polygon
library(sf)
#st_point(as.matrix(expand.grid(seq(0.5,4.5,1), seq(0.5,4.5,1))))
points <- st_multipoint(as.matrix(expand.grid(seq(0.5,4.5,1), seq(0.5,4.5,1))))
plot(points)
st_polyg

pol <- st_polygon(list(matrix(c(0,0,4,4,0,4,0,0), byrow = T, ncol = 2)))
pol2 <- st_polygon(list(matrix(c(0,0,0,4,4,0,0,0), byrow = T, ncol = 2)))
plot(pol)
plot(pol2)

st_intersection(pol, pol2) %>% plot()

st_intersection(points, pol) %>% plot()
st_polygonize(points)
st_linestring(points) %>% plot()

data.frame(points)

st_as_sf(points)
?st_point

points
points
st_coordinates(points)[1, 1:2] + matrix(c(-0.5,-0.5,0.5,-0.5,0.5,0.5,-0.5,0.5,-0.5,-0.5), byrow = T, ncol = 2)

dat <- data.frame(x = letters[1:5])
dat %>% 
  mutate(y = 4,
         y2 = list(4,5))
foo <- function(x) c(x-3, x, x+3)
dat %>% group_by(x) %>% nest()
dat %>% mutate(y = 3, d = map(y, foo)) %>% unnest(cols = c(d))
