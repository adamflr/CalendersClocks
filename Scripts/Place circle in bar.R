# Place circle around a plot ----
# Create example data ----
source("Scripts/Example data.R", encoding = "UTF-8")

# Create plot. Extract gtable and gbuild ----
library(ggplot2)
dat$counts[2] <- 5
g <- ggplot(dat, aes(flowers, counts)) + geom_bar(stat = "identity", col = "black", fill = "white")
g_build <- ggplot_build(g)
g_table <- ggplot_gtable(g_build)

# Plot and find viewport ----
g
library(grid)
vp.mid <- viewport(0.5,0.5,1,1, layout = gtable:::gtable_layout(g_table))
pushViewport(vp.mid)
vp <- viewport(layout.pos.row = 7, layout.pos.col = 5)
pushViewport(vp)

temp <- g_table$grobs[[6]]$children$geom_rect.rect

library(magick)

# Crop circle
s <- seq(-1, 1, length.out = 200)
mat1 <- expand.grid(x = s, y = s)
mat <- matrix(mat1$x^2 + mat1$y^2, 200)
mat <- ifelse(mat > 0.9, "white", rgb(0,0,0,0))

# For-loop for images
im <- c("Achillea millefolium.jpg", "Aegopodium podagraria.jpg", "Allium oleraceum.jpg", 
        "Anemone nemorosa.jpg", "Anthriscus sylvestris.jpg", "Armeria maritima.jpg")
i <- 1
vp_box <- viewport(temp$x[i], temp$y[i], temp$width[i], temp$height[i], just = temp$just)
pushViewport((vp_box))
#plot.new()

grid.rect()

a <- image_read(paste0("Example pictures/", im[i]))
a <- image_crop(a, "+100+100")
a <- image_crop(a, "200x200")
a <- rasterGrob(a)
b <- grid.circle(gp = gpar(lwd = 20, col = "white", fill = NA), draw = F)
d <- grid.circle(gp = gpar(lwd = 2, col = "black", fill = NA), draw = F)
c <- rasterGrob(mat)
g <- grobTree(a, c, b, d)
#pushViewport(viewport(height = temp$width[1], y = 0.01, just = "bottom"))
grid.draw(g)
grid.rect(gp = gpar(fill = NA))
#grid.raster(as.raster(a), y = 0.01, just = "bottom")
#grid.raster(mat, y = 0.01, just = "bottom")
#grid.circle(y = 0.1, gp = gpar(lwd = 50, fill = NA, col = "white"))
#grid.rect(gp = gpar(fill = 0))
popViewport(1)
