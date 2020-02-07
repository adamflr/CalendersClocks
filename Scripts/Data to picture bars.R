# Create ggplot (bar chart) and draw images in each bar ----
# Create example data ----
source("Scripts/Example data.R", encoding = "UTF-8")

# Create plot. Extract gtable and gbuild ----
library(ggplot2)
g <- ggplot(dat, aes(flowers, counts, fill = flowers)) + geom_bar(stat = "identity")
g_build <- ggplot_build(g)
g_table <- ggplot_gtable(g_build)

# Plot and find viewport ----
g
library(grid)
vp.mid <- viewport(0.5,0.5,1,1, layout = gtable:::gtable_layout(g_table))
pushViewport(vp.mid)
vp <- viewport(layout.pos.row = 7, layout.pos.col = 5)
pushViewport(vp)

temp <- g_table$grobs[[6]]$children$geom_rect.rect.91

# For-loop for images
im <- c("Achillea millefolium.jpg", "Aegopodium podagraria.jpg", "Allium oleraceum.jpg", 
        "Anemone nemorosa.jpg", "Anthriscus sylvestris.jpg", "Armeria maritima.jpg")
for(i in 1:length(im)){
vp_box <- viewport(temp$x[i], temp$y[i], temp$width[i], temp$height[i], just = temp$just)
pushViewport((vp_box))

# Draw and image ----
uwo <- jpeg::readJPEG(paste0("Example pictures/", im[i]))
uwo <- uwo[1:50,1:200,]
x1 <- uwo[, , 1] #the "r" of rgb 
x2 <- uwo[, , 2] #the "g" 
x3 <- uwo[, , 3] #the "b" 
widthno <- ncol(x1) 
heightno <- nrow(x1)
xygrid <- expand.grid(seq(1, 2*widthno,2)/(2*widthno), 
                    seq(1, 2*heightno,2)/(2*heightno))
vp<-viewport(h=min(1,heightno/widthno),
             w=min(1,widthno/heightno),
             gp = gpar(alpha=1)) 
pushViewport(vp) 
grid.rect(height = 1/heightno,
          width = 1/widthno,
          x = rev(xygrid$Var1), 
          y = xygrid$Var2,
          gp = gpar(fill=rgb(rev(as.vector(t(x1))),
                             rev(as.vector(t(x2))),
                             rev(as.vector(t(x3))),1),
                    lty="blank")) 
popViewport(2)
}
