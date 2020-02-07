plot.new()
library(grid)
vp <- viewport(width = 0.5, height = 0.5)
pushViewport(vp)
grid.rect()
grid.rect(x = 1:8/4, y = 1:8/4, width = 1/4, height = 1/4)
im <- jpeg::readJPEG("Example pictures/Achillea millefolium.jpg")
im <- im[1:50, 1:50, ]
#as.raster(im)
?rasterImage(im,0,0,1,1)
grid.rect(grid::rasterGrob(im))
gr <- rasterGrob(im)
gr1 <- grid.rect(draw = F)
grid:::drawGrob(gr1)
grid:::drawGrob(gr)
grid.rect()
gr
gr$x
popViewport(1)
pushViewport(viewport())

grid.rect(height = 0.5, width = 1, just = "top", gp = gpar(fill = "blue"))
im <- image_read("Example pictures/Achillea millefolium.jpg")
grid.raster(as.raster(im), height = 0.5, width = 0.5, just = "top")
