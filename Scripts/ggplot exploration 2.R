# Exploring the grid package. Pushing viewports
library(grid)
pushViewport(viewport(y = unit(3, "lines"), width = 0.9, height = 0.8,
                      just = "bottom", xscale = c(0, 100)))
grid.rect(gp = gpar(col = "grey"))
grid.xaxis()
pushViewport(viewport(x = unit(60, "native"), y = unit(0.5, "npc"),
                      width = unit(1, "strwidth", "coordinates for everyone"),
                      height = unit(3, "inches")))
grid.rect()
grid.text("coordinates for everyone")
popViewport(2)
?popViewport

g_table
?pushViewport()
downViewport("panel")
pushViewport(viewport(x=0.5, width=0.4, height=0.8,
                      just="left", name="C"))
class(g_table)
childNames(g_table)
is.grob(g_table)
getGrob(g_table, "panel")
g_table$grobs[[6]]
pushViewport(g_table$grobs[[6]])

class(g_table$grobs[[6]])
g_table$grobs
plot(t(g_table))
plot(g_table[7,5])
gtable::gtable_height(g_table)
gtable::gtable_show_layout(g_table)
g

#g
#This section pushes to the panel viewport of the ggplot
vp.mid <- viewport(0.5,0.5,1,1, layout = gtable:::gtable_layout(g_table))
pushViewport(vp.mid)
vp <- viewport(layout.pos.row = 7, layout.pos.col = 5)
pushViewport(vp)
grid.rect()

grid.show.layout(g_table)
?grid.show.layout
