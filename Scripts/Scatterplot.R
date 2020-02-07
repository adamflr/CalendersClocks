# Scatterplot. ggplot2 exploration
source("Scripts/Example data.R")
dat
set.seed(8)
dat$weight <- runif(6)

# Construct ggplot
library(ggplot2)
g <- ggplot(dat, aes(weight, counts, col = flowers)) +
  geom_point()
print(g)

g_build <- ggplot_build(g)
g_table <- ggplot_gtable(g_build)

library(grid)
vp.mid <- viewport(0.5,0.5,1,1, layout = gtable:::gtable_layout(g_table))
pushViewport(vp.mid)
vp <- viewport(layout.pos.row = 7, layout.pos.col = 5)
pushViewport(vp)
grid.rect()
temp <- g_table$grobs[[6]]$children$geom_point.point
temp$x
