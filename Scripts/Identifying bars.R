# Draw inside an area of a plot
g_build$data # Contains the data being plotted
g_build$layout
attributes(g_build$data)
g_build$layout$panel_scales_x[[1]]$range_c$range # Range in x
g_build$layout$panel_scales_y[[1]]$limits # Range in y

g_table
g_table$grobs[[6]]$children$geom_rect.rect.91$gp
dat

g
vp.mid <- viewport(0.5,0.5,1,1, layout = gtable:::gtable_layout(g_table))
pushViewport(vp.mid)
vp <- viewport(layout.pos.row = 7, layout.pos.col = 5)
pushViewport(vp)

vp_box <- viewport(temp$x[1], temp$y[1], temp$width[1], temp$height[1], just = temp$just)
pushViewport((vp_box))

vp_box$justification

grid.rect()
temp <- g_table$grobs[[6]]$children$geom_rect.rect.91
grid.rect(x = temp$x,
          y = temp$y,
          width = temp$width,
          height = temp$height, 
          vp = vp)
popViewport(1)

grid:::drawGrob(temp)
temp$height[1] <- unit(0.25, "native")
temp$x[1] <- unit(0.02, "native")
temp$y; temp$height
as.numeric(temp$y) - as.numeric(temp$height)

temp
