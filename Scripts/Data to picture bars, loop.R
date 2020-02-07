# Create ggplot (bar chart) and draw images in each bar ----
# Create example data ----
source("Scripts/Example data.R", encoding = "UTF-8")

# Create plot. Extract gtable and gbuild ----
library(ggplot2)
dat$counts[2] <- 20
g <- ggplot(dat, aes(flowers, counts)) + geom_bar(stat = "identity", col = "black", fill = "white") + theme_bw()
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

# For-loop for images
im <- c("Achillea millefolium.jpg", "Aegopodium podagraria.jpg", "Allium oleraceum.jpg", 
        "Anemone nemorosa.jpg", "Anthriscus sylvestris.jpg", "Armeria maritima.jpg")
mat <- raster_circle(200, radius = 1)
for(i in 1:length(im)){
  
  vp_box <- viewport(temp$x[i], temp$y[i] - temp$height[i], temp$width[i], min(temp$height[i], temp$width[i]), 
                     just = c("left", "bottom"), clip = "inherit")
  pushViewport((vp_box))
  #plot.new()
  
  a <- image_read(paste0("Example pictures/", im[i]))
  a <- image_crop(a, "+100+100")
  a <- image_crop(a, "200x200")
  a <- rasterGrob(a)
  b <- grid.circle(gp = gpar(lwd = 0, col = "white", fill = NA), draw = F)
  d <- grid.circle(gp = gpar(lwd = 2, col = "black", fill = NA), draw = F)
  c <- rasterGrob(mat, gp = gpar(alpha = 0.2))
  g <- grobTree(a, c, b, d)
  #pushViewport(viewport(height = temp$width[1], y = 0.01, just = "bottom"))
  grid.draw(g)
  #grid.rect(gp = gpar(fill = NA, lwd = 0, col = NA))
  #grid.circle(y = 0.1, gp = gpar(lwd = 50, fill = NA, col = "white"))
  #grid.rect(gp = gpar(fill = 0))
  popViewport(1)
}

for(i in 1:length(im)){
  
  vp_box <- viewport(temp$x[i], temp$y[i], temp$width[i], temp$height[i], just = temp$just)
  pushViewport((vp_box))
  grid.rect(gp = gpar(fill = NA, lwd = 2, col = "black"))
  popViewport(1)
}