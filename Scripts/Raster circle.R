# Raster circle
raster_circle <- function(size = 100, col = "white", radius = 0.9){
  s <- seq(-1, 1, length.out = size)
  mat1 <- expand.grid(x = s, y = s)
  mat <- matrix(mat1$x^2 + mat1$y^2, size)
  mat <- ifelse(mat > radius, col, rgb(0,0,0,0))
  mat
}

# Round raster image
roundifyImage <- function(image, col = "white", radius = 0.9){
  d <- dim(image)[1]
  mat <- raster_circle(d, col = col, radius = radius)
  image[mat == col] <- rgb(0,0,0,0)
  image
}

library(magick)
a <- image_read("Example pictures/Achillea millefolium.jpg")
a <- as.raster(a)
dim(a)
plot.new()
pushViewport(viewport(height = 0.5, width = 0.5))
grid.rect()
grid.raster(a)
grid.rect(gp = gpar(fill = "green"))
grid.raster(roundifyImage(a, radius = 1), interpolate = F)
grid.circle(gp = gpar(fill = NA, lwd = 2, col = "white"))
grid.raster(raster_circle(100, "green"), interpolate = F)
