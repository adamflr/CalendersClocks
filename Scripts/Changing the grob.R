# Changing the grob
g
vp.mid <- viewport(0.5,0.5,1,1, layout = gtable:::gtable_layout(g_table))
pushViewport(vp.mid)
vp <- viewport(layout.pos.row = 7, layout.pos.col = 5)
pushViewport(vp)
grid.rect()

temp <- g_table$grobs[[6]]$children$geom_rect.rect.91

temp$gp$fill <- rep("#F8766DFF", 6)

grid:::drawGrob(temp)

uwo <- jpeg::readJPEG("Example pictures/Achillea millefolium.jpg")
dim(uwo)

x1 <- uwo[, , 1] #the "r" of rgb 
x2 <- uwo[, , 2] #the "g" 
x3 <- uwo[, , 3] #the "b" 
widthno <- ncol(x1) 
heightno <- nrow(x1)
xygrid<-expand.grid(seq(1,2*widthno,2)/(2*widthno), 
                    seq(1,2*heightno,2)/(2*heightno))
#pushViewport(viewport()) 
#vp<-viewport(h=min(1,heightno/widthno),
#             w=min(1,widthno/heightno),
#             gp = gpar(alpha=1)) 
#pushViewport(vp) 
t2 <- grid.rect(height = 1/heightno,
                width = 1/widthno,
                x = rev(xygrid$Var1), 
                y = xygrid$Var2,
                gp = gpar(fill=rgb(rev(as.vector(t(x1))),
                                   rev(as.vector(t(x2))),
                                   rev(as.vector(t(x3))),1),
                          lty="blank", alpha = 0.3), 
                draw = F) 
t2$gp
t2$x[1:10]
grid:::drawGrob(t2)
