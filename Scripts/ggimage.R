# A look at ggimage
library(ggimage)
dat <- data.frame(x = 1:3, y = 0, l = "https://upload.wikimedia.org/wikipedia/commons/6/69/Kurre5.jpg")
g <- ggplot(dat, aes(x, y, image = l)) + geom_image(size = 0.25)

g_build <- ggplot_build(g)
g_table <- ggplot_gtable(g_build)

g_table$grobs[[6]]$children$geom_image.fixasp_raster.813$children$GRID.rastergrob.811$raster %>% plot()
g_table$grobs[[6]]$children$geom_image.fixasp_raster.813$children$GRID.rastergrob.811$raster[1:1000,1:1000] <- NA

grid.draw(g_table)
?geom_image
