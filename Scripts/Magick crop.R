# Change size of plot
library(magick)
a <- image_read("Example pictures/Achillea millefolium.jpg")
a
image_crop(a, "+50+100")
dim(a)
image_crop(a, "100x100")

image_data(a) -> b
dim(b)

image_crop(a, "100x100")

a

plot.new()
pushViewport(viewport(width = 0.5, height = 0.5))
library(grid)
grid.rect()
grid.raster(as.raster(a))
grid.circle(gp = gpar(lwd = 10, fill = NA))
?grid.circle

?grid.clip()

