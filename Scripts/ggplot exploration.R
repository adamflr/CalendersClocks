# ggplot, base
library(ggplot2)
g <- ggplot(dat, aes(flowers, counts, fill = flowers)) + geom_bar(stat = "identity") + ylim(-10,365)
g

g_build <- ggplot_build(g)
g_table <- ggplot_gtable(g_build)
g_build$data[[1]]$ymax <- 75
draw(g_table)
grid::grid.draw(g_table)

g_table
g_table$layout
g_table$widths
str(g_table$grobs[[6]])
?grid::draw
?grid::grid.draw
class(g_table)
grid:::grobWidth(g_table$grobs[[6]])
g_table
library(grid)
childNames(g_table$grobs[[6]])
g_table$widths
