# Magick, fade, crop
library(magick)
a <- image_read("Example pictures/Achillea millefolium.jpg")

# Fade
cols <- c(rgb(1,0,0,1), rgb(1,0,0,0))
mat <- matrix(cols[c(1,1,2,2,2,2,2,2)], 2)

ras1 <- as.raster(t(mat))
#ras1

plot.new()
pushViewport(viewport(width = 0.5, height = 0.5))

grid.rect(gp = gpar(fill = "red"))
grid.raster(as.raster(a))
grid.raster(ras1, height = 1, width = 1)

# Crop circle
s <- seq(-1, 1, length.out = 200)
mat1 <- expand.grid(x = s, y = s)
mat <- matrix(mat1$x^2 + mat1$y^2, 200)
mat <- ifelse(mat > 1, "white", rgb(0,0,0,0))

dim(mat)
grid.raster(mat)

mat[1:10, 1:10]            
