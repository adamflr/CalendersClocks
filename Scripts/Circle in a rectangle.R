plot.new()
pushViewport(viewport(width = unit(5, "cm"), height = unit(5, "cm")))
grid.rect(gp = gpar(fill = "red"))
#grid.circle(gp = gpar(lwd = 50)) # Want the circle to be inside the rectangle
#grid.circle(gp = gpar(lwd = unit(50, "mm")))
grid.circle(r = unit(2, "cm"), gp = gpar(lwd = unit(10, "cm")))
