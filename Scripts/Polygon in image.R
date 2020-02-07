# Polygon with image using grid functions
dat <- data.frame(x = c(1,2,3,1)/3, y = c(1,0,5,1)/5, 
                  im = "https://upload.wikimedia.org/wikipedia/commons/6/69/Kurre5.jpg",
                  stringsAsFactors = F)

grid.newpage()
grid.polygon(dat$x/3, dat$y/5)

vp <- viewport(width = 0.5, height = 0.5)
pushViewport(vp)
grid.rect()
grid.polygon(dat$x/3, dat$y/5)
upViewport()
grid::current.viewport()

# Import as pixels in jpg
library(rgdal)
library(dplyr)
img_path <- "Example pictures/Kurre5.jpg"
#img_path <- "https://upload.wikimedia.org/wikipedia/commons/6/69/Kurre5.jpg"
img <- readGDAL(img_path)

df <- expand.grid(x = 1:img@bbox[1,2], y = img@bbox[2,2]:1)
df$b1 <- img$band1
df$b2 <- img$band2
df$b3 <- img$band3

#df <- df %>% filter(abs(((x-500)/200) ^5) < y)
ggplot(df, aes(xmin = x - 1, xmax = x, ymin = y - 1, ymax = y)) + 
  geom_rect(fill = rgb(df$b1/360, df$b2/360, df$b3/360)) +
  coord_equal()

# Set picture to (0,1)-square
df %>% 
  filter(y <= max(x)) %>% 
  mutate(x_max = x + 1,
         y_max = y + 1,
         x = x / max(x),
         y = y / max(y),
         x_max = x_max / (max(x_max) -1),
         y_max = y_max / (max(y_max) -1)) -> df

ggplot(df, aes(xmin = x, xmax = x_max, ymin = y, ymax = y_max)) + 
  geom_rect(fill = rgb(df$b1/360, df$b2/360, df$b3/360)) +
  coord_equal()

# df %>% filter(abs(x - 0.5)^1.2 + (y - 0.5)^2 < 0.25) -> df
# ggplot(df, aes(xmin = x, xmax = x_max, ymin = y, ymax = y_max)) + 
#   geom_rect(fill = rgb(df$b1/360, df$b2/360, df$b3/360)) +
#   coord_equal()

# Crop using spatial functions
library(spatial)
library(raster)

dat_po <- Polygon(dat %>% select(x, y))
Polygon(list(dat_po))
SpatialPolygons(list(dat_po))

dat_ra <- raster()
