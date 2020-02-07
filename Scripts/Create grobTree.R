plot.new()
a <- grid.circle(r = 0.5, draw = F)
b <- grid.circle(r = 0.45, draw = F)
g <- grobTree(a, b)
grid.draw(g)
?gTree
g
a
grid.draw(a)
grid.draw(b)

a <- image_read("Example pictures/Achillea millefolium.jpg")
a <- rasterGrob(a)
#a
#grid.draw(a)
#mat

b <- grid.circle(gp = gpar(lwd = 20, col = "white", fill = NA), draw = F)
d <- grid.circle(gp = gpar(lwd = 2, col = "black", fill = NA), draw = F)
c <- rasterGrob(mat)
g <- grobTree(a, c, b, d)

plot.new()
grid.draw(g)
grid.rect(gp = gpar(fill = NA))

a
grid.draw(a)
grid.draw(b)
g
