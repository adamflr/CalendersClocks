# Crop to polygon
# Create a grid and a polygon ----
library(dplyr)
dat_pol <- data.frame(x = c(1,2,3,1)/3, y = c(1,0,5,1)/5)
plot(0:1,0:1)
polygon(dat_pol)

dat_gr <- expand.grid(x = seq(0.125,0.875, 0.250),
                      y = seq(0.125,0.875, 0.250)) %>% 
  mutate(x_0 = x - 0.125, y_0 = y - 0.125,
         x_1 = x + 0.125, y_1 = y + 0.125,
         col = rgb(runif(16), runif(16), runif(16)))

points(dat_gr %>% select(x,y))

# Plot grid and polygon
library(ggplot2)
ggplot(dat_gr, aes(xmin = x_0, xmax = x_1, ymin = y_0, ymax = y_1)) +
  geom_rect(fill = dat_gr$col) +
  geom_polygon(aes(x, y), data = dat_pol, inherit.aes = F, fill = NA, col = "red")

# Create spatial objects from grid and polygon ----
library(raster)
library(spatial)

# Grid
GridTopology(c(0.125,0.125), c(0.25, 0.25), c(4,4)) %>% 
  SpatialGridDataFrame(dat_gr %>% arrange(desc(x), desc(y))) -> sp_gr # PROBABLY LEAVES DATA AND GRID IN WRONG ORDER

# Raster
sp_ra <- raster(sp_gr)
plot(sp_ra)
values(sp_ra) <- col2rgb(dat_gr$col)[1,]

# Spatial polygon?
sp_pol <- Polygon(dat_pol)
sp_pol <- Polygons(list(sp_pol), "sp1")
sp_pol <- SpatialPolygons(list(sp_pol))

# Cropping and masking
# crop(sp_gr, sp_pol) %>% plot()

mask(sp_ra, sp_pol, mask = ) %>% plot()

# Disaggregare, then mask
disaggregate(sp_ra, fact = 2500) %>% 
  mask(sp_pol) %>% 
  plot()

disaggregate(sp_ra, fact = 250) %>% 
  mask(sp_pol) -> sp_mask

sp_mask@data
#values(sp_mask)
sp_mask@ncols
dat_t <- expand.grid(x = 1:sp_mask@ncols, y = sp_mask@nrows:1) %>% 
  mutate(vals = values(sp_mask)) %>% 
  filter(!is.na(vals))
ggplot(dat_t, aes(x, y)) + 
  geom_point(col = rgb(dat_t$vals/max(dat_t$vals), 0, 0), size = 3) +
  coord_equal()

# Transform raster to shape, then raster::intersect
plot(sp_ra, axes = T)
sp_pol2 <- rasterToPolygons(sp_ra)

plot(sp_pol2, col = rgb(unlist(sp_pol2@data)/250, 0.5, 0.7))

intersect(sp_pol2, sp_pol) -> sp_int
sp_int@polygons %>% length()

extract_pol_at_i <- function(x){sp_int@polygons[[x]]@Polygons[[1]]@coords}
dat_pol_gg <- data.frame()
for(i in 1:length(sp_int@polygons)){
  data.frame(extract_pol_at_i(i), id = i) %>% 
    rbind(dat_pol_gg) -> dat_pol_gg
}
dat_pol_gg %>% dim()

g <- ggplot(dat_pol_gg, aes(x, y, fill = as.character(id))) + geom_polygon() + coord_equal()
ggsave("Output/200208_intersection.pdf", g)
