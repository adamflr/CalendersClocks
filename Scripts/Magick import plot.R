# Import and plot using magick
library(magick)
a <- image_read("Example pictures/Achillea millefolium.jpg")
a
a_raster <- as.raster(a)

library(grid)
grid.raster(a_raster)

plot(1)
pushViewport(viewport(width = 0.5, height = 0.5))
grid.rect(gp = gpar(fill = 2, alpha = 0.2))
grid.raster(a_raster, width = 1, height = 1, gp = gpar(alpha = 0.2))

b <- rasterGrob(a_raster)
grid.draw(b)

source("Scripts/Example data.R")
dat

x <- c(0.00, 0.40, 0.86, 0.85, 0.69, 0.48, 0.54, 1.09, 1.11, 1.73, 2.05, 2.02)
library(lattice)
barchart(1:12 ~ x, origin=0, col="white", 
         panel=function(x, y, ...) {
           panel.barchart(x, y, ...)
           grid.raster(a_raster, x = 0, width = 0.25, y = y,
                       default.units="native",
                       just="left",
                       height=unit(2/37,
                                   "npc"))
           })
barchart
lattice:::bwplot.formula
