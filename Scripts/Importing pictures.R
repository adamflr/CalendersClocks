# Pictures as objects for plots?
library(grImport)
PostScriptTrace("Example pictures/Achillea millefolium.jpg")

uwo <- jpeg::readJPEG("Example pictures/Achillea millefolium.jpg")
uwo
class(uwo)
dim(uwo)

vp.mid <- viewport(0.5,0.5,1,1, layout = gtable:::gtable_layout(g_table))
pushViewport(vp.mid)
vp <- viewport(layout.pos.row = 7, layout.pos.col = 5)
pushViewport(vp)

# Draw a picture based on a jpg array. Based on http://jse.amstat.org/v18n3/zhou.pdf
x1<-uwo[,,1] #the "r" of rgb 
x2<-uwo[,,2] #the "g" 
x3<-uwo[,,3] #the "b" 
widthno<-ncol(x1) 
heightno<-nrow(x1)
xygrid<-expand.grid(seq(1,2*widthno,2)/(2*widthno), 
                    seq(1,2*heightno,2)/(2*heightno))
pushViewport(viewport()) 
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