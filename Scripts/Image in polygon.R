# Image in polygon
library(grid)
library(maps)
#par(mar=rep(0, 4))
#map(region = "Spain", col = "black", fill=TRUE)
#mask <- grid.cap()

plot.new()
a <- expand.grid(x = 1:500, y = 1:500)
a$z <- ifelse(a$x < 250 & a$y < 250 & a$x*a$y > 750, "transparent", "black")
a <- matrix(a$z, 500)
grid.raster(a)

im <- jpeg::readJPEG("Example pictures/Achillea millefolium.jpg")

#espana <- readPNG("1000px-Flag_of_Spain.png")
espanaRaster <- as.raster(im)
espanaRaster <- espanaRaster[, 1:500]
mask <- a[1:500, ]

espanaRaster[mask != "black"] <- "transparent"

grid.raster(espanaRaster)

par(mar=rep(0, 4))
#map(region="Spain")
grid.raster(espanaRaster, y=1, just="top")
#map(region="Spain", add=TRUE)
