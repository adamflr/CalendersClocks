# Grid polygon
plot.new()
pushViewport(viewport(height = 0.5, width = 0.5))
grid.rect()
grid.points(c(0,1,0,1), c(0,0,1,1))
grid.polygon(c(0,0.5,1,0.5), c(0.5, 1, 0.5, 0), gp = gpar(fill = "green"))

x1 <- seq(-1, 1, 0.01)

x <- c(x1, rev(x1))
y <- c(sqrt(1 - x1^2), -sqrt(1 - x1^2))
x <- 0.5 + x/2
y <- 0.5 + y/2

plot(x,y, t = "l")

plot.new()
pushViewport(viewport(height = 0.5, width = 0.5))
grid.rect()
grid.polygon(x, y, gp = gpar(fill = "green"))

x1 <- seq(-1, 1, 0.001)

x <- c(x1, rev(x1))
y <- c(sqrt(1 - x1^2), -sqrt(1 - x1^2))

x <- c(x, 0.9 * rev(x))
y <- c(y, 0.9 * rev(y))

x <- 0.5 + x/2
y <- 0.5 + y/2

plot.new()
pushViewport(viewport(height = 0.5, width = 0.5, clip = "on"))
grid.rect()
grid.circle(r = 0.75, gp = gpar(fill = "red"))
grid.polygon(x, y, default.units = "npc", gp = gpar(fill = "green", col = NA))
grid.circle()

library(magick)
im <- image_read("Example pictures/Achillea millefolium.jpg")
grid.raster(as.raster(im), height = 1, width = 1)

a$x
?viewport
