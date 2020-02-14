# From points to grid/polygon
library(sf)
st_point(as.matrix(expand.grid(seq(0.5,4.5,1), seq(0.5,4.5,1))))
points <- st_multipoint(as.matrix(expand.grid(seq(0.5,4.5,1), seq(0.5,4.5,1))))
pol <- st_polygon(list(matrix(c(0,0,4,4,0,4,0,0), byrow = T, ncol = 2)))
st_intersection(points, pol) %>% plot()
